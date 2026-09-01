from pathlib import Path
import re, sys
root=Path(sys.argv[1] if len(sys.argv)>1 else 'content')
errors=[]; warnings=[]
forbidden={'.pdf','.ppt','.pptx','.doc','.docx','.xls','.xlsx','.zip','.7z','.rar'}
for p in root.rglob('*'):
    if p.is_file() and p.suffix.lower() in forbidden:
        errors.append(f'Forbidden source/binary file: {p}')

files=list(root.rglob('*.md'))
# map stems and relative no-extension paths
relmap={p.relative_to(root).with_suffix('').as_posix():p for p in files}
stemmap={}
for k,p in relmap.items(): stemmap.setdefault(p.stem,[]).append(k)

patterns={
 'email': re.compile(r'[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'),
 'phone_id': re.compile(r'(?<!\d)(?:\+62|08)[0-9 .-]{7,}(?!\d)'),
 'long_id': re.compile(r'(?<!\d)\d{10,}(?!\d)'),
 'medical_record': re.compile(r'(?i)\b(?:nomor|no\.)\s*(?:rekam\s+medis|rm)\b\s*[:#-]\s*[A-Za-z0-9-]{3,}'),
}
private_terms=re.compile(r'(?i)\b(RSUP Fatmawati|RSU Hermina Depok|NPM\s*[:#-]?\s*\d+)\b')
link_re=re.compile(r'!?(?:\[\[)([^\]|#]+)(?:#[^\]|]+)?(?:\|[^\]]+)?\]\]')
for p in files:
    text=p.read_text(encoding='utf-8')
    for name,rx in patterns.items():
        for m in rx.finditer(text):
            # allow URLs and dates; this scanner errs on safety
            errors.append(f'{name}: {p.relative_to(root)} -> {m.group(0)[:80]}')
    for m in private_terms.finditer(text): errors.append(f'private_term: {p.relative_to(root)} -> {m.group(0)}')
    for target in link_re.findall(text):
        t=target.strip().replace('\\','/')
        if not t: continue
        if t.endswith('.md'): t=t[:-3]
        # exact relative-from-root link
        if t in relmap: continue
        # Obsidian shortest link by stem
        if '/' not in t and t in stemmap: continue
        # path links may omit exact leading number only if file stem unique
        if Path(t).name in stemmap: continue
        warnings.append(f'Possible broken wikilink: {p.relative_to(root)} -> [[{target}]]')

print(f'Checked {len(files)} Markdown files')
if warnings:
    print(f'Warnings: {len(warnings)}')
    for x in warnings[:80]: print('WARN',x)
if errors:
    print(f'Errors: {len(errors)}')
    for x in errors[:100]: print('ERROR',x)
    sys.exit(1)
print('PASS: no forbidden binaries or obvious privacy patterns detected')
