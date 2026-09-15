# Git

Configuração global de Git simples e previsível, pensada para Linux/WSL e uso diário.

## Instalação

Faça backup da configuração atual e copie o arquivo:

```bash
cp ~/.gitconfig ~/.gitconfig.bak 2>/dev/null || true
cp git/.gitconfig ~/.gitconfig
```

Depois configure sua identidade localmente:

```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"
```

## Decisões da configuração

- `main` como branch padrão para novos repositórios.
- `git pull` aceita apenas fast-forward, evitando merges ou rebases automáticos inesperados.
- branches remotas apagadas são limpas durante `fetch`.
- o primeiro `push` configura automaticamente o upstream.
- conflitos usam `diff3`, mostrando também a base comum.
- diffs usam o algoritmo `histogram`.
- commits abertos no editor mostram o diff para revisão.
- `nvim` é usado como editor padrão.
- finais de linha são mantidos em LF no repositório em ambientes Linux/WSL.

A configuração evita aliases, hooks e automações que mudem o histórico silenciosamente.
