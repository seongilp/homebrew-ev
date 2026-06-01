# homebrew-ev

Homebrew tap for [`ev`](https://github.com/seongilp/ev) — an Everything-style
terminal file searcher (rg + fzf + fd) with office-document (hwpx/docx/pptx/xlsx/pdf)
text extraction.

## Install

```bash
brew tap seongilp/ev      # once
brew install ev           # then just `ev`
brew upgrade ev           # update
```

Or in one line:

```bash
brew install seongilp/ev/ev
```

Bleeding edge from `main`:

```bash
brew install --HEAD seongilp/ev/ev
```

## Usage

```bash
ev              # interactive TUI search in the current folder
ev ~/work       # search a specific folder
ev -g 유동성 ~/docs --format md > report.md   # non-interactive content search
```

See the [main repository](https://github.com/seongilp/ev) for full docs.
