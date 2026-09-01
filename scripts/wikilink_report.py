from pathlib import Path
import re,sys
root=Path(sys.argv[1] if len(sys.argv)>1 else 'content')
files=list(root.rglob('*.md'))
rel={p.relative_to(root).with_suffix('').as_posix():p for p in files}
stems={}
for k,p in rel.items(): stems.setdefault(p.stem,[]).append(k)
rx=re.compile(r'!?(?:\[\[)([^\]|#]+)(?:#[^\]|]+)?(?:\|[^\]]+)?\]\]')
broken=[]
for p in files:
  for t in rx.findall(p.read_text(encoding='utf-8')):
    t=t.strip().replace('\\','/'); t=t[:-3] if t.endswith('.md') else t
    if t in rel or ('/' not in t and t in stems) or Path(t).name in stems: continue
    broken.append((p.relative_to(root),t))
print('files',len(files),'links unresolved',len(broken))
for a,b in broken[:200]: print(a,'->',b)
sys.exit(bool(broken))
