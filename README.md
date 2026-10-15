# LaTeX-Vorlage für Hausarbeiten und Masterarbeit (HSBI, FB Wirtschaft)

Setzt das Layout aus [`leitfaden.pdf`](leitfaden.pdf) um: Arial 11 pt, 1,5-zeilig, Ränder 3/2/2/2 cm, Titelblatt und Kopfzeile wie im Leitfaden. Die Seitenzählung ist römisch (Verzeichnisse), dann arabisch (Text), dann wieder römisch (Literatur, Anhang). Zitiert wird nach Harvard (Autor-Jahr).

## Neue Arbeit anlegen

```bash
cp -R vorlage ~/Documents/Masterarbeit
```

Dann in `main.tex` anpassen:

- Sprache: `\documentclass[ngerman]{hsbi-arbeit}` oder `[english]`
- Angaben fürs Titelblatt (Titel, Name, Matrikelnummer, Studiengang, Prüfer …)
- **Hausarbeit:** `\arbeitstyp{Hausarbeit}`, die Zeilen `\zweitpruefer` und `\input{abstract}` löschen
- Abbildungs- und Tabellenverzeichnis laut Leitfaden nur bei mehr als drei Einträgen, sonst die Zeile löschen

Kapitel liegen in `kapitel/`, Quellen in `literatur.bib` (Export aus Zotero oder Citavi im Format BibLaTeX), Abkürzungen in `abkuerzungen.tex`.

## Bauen

```bash
latexmk main.tex
```

Das braucht LuaLaTeX und biber (beides in MacTeX bzw. TeX Live). Ergebnis ist `main.pdf`.

## Die wichtigsten Befehle

| Zweck | Befehl | Ergebnis |
|---|---|---|
| Zitat mit Seite | `\autocite[12]{key}` | (Müller 2023, S. 12) |
| Sinngemäß | `\autocite[vgl.][12]{key}` | (vgl. Müller 2023, S. 12) |
| Name im Satz | `\textcite{key}` | Müller (2023) |
| Abkürzung | `\ac{edi}` | beim ersten Mal ausgeschrieben, danach EDI |
| Verweis | `\autoref{abb:beispiel}` | Abbildung 1 |
| Abkürzungsteile | `z.\,B.` | z. B. mit schmalem, geschütztem Leerzeichen |

Beispiele für Abbildung, Tabelle und Quellcode stehen in `kapitel/02-grundlagen.tex`.

## Eigenständigkeitserklärung

Das [hochschulweite Formular](https://www.hsbi.de/pruefungsangelegenheiten/hochschulweite-dokumente) ausfüllen, unterschreiben und als `erklaerung.pdf` neben `main.tex` legen. Es wird automatisch als letzte Seite eingebunden.

## Abweichungen vom Word-Muster

- Das Titelblatt hat oben und unten eine Doppellinie und einen fetten Titel. Die Prüferangaben gehen über die volle Breite.
- Der Textteil beginnt bei Seite 1. Das Word-Muster zählt nach den römischen Seiten weiter (ab 6).
- Im Literaturverzeichnis steht das Jahr nach dem Namen (Harvard). Das Muster im Leitfaden gehört zur Fußnoten-Zitierweise.
