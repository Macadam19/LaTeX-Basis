% hsbi-arbeit.cls – Layout nach dem Leitfaden für Abschlussarbeiten
% HSBI, Fachbereich Wirtschaft (siehe leitfaden.pdf). Kompilieren mit LuaLaTeX + biber.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hsbi-arbeit}[2026/10/15 Wissenschaftliche Arbeiten HSBI FB Wirtschaft]

% Sprache der Arbeit: \documentclass[ngerman]{...} oder \documentclass[english]{...}
\newcommand*{\hsbi@sprache}{ngerman}
\DeclareOption{ngerman}{\renewcommand*{\hsbi@sprache}{ngerman}}
\DeclareOption{english}{\renewcommand*{\hsbi@sprache}{english}}
\ProcessOptions\relax

\LoadClass[
  fontsize=11pt, oneside,
  parskip=half, numbers=noenddot,
  listof=totoc, listof=entryprefix,
  captions=tableheading, captions=nooneline,
]{scrreprt}

\RequirePackage[setspace=false]{scrhack}% bindet listings und setspace sauber an KOMA an
\RequirePackage{fontspec}
\IfFontExistsTF{Arial}
  {\setmainfont{Arial}\setsansfont{Arial}}
  {\setmainfont{TeX Gyre Heros}\setsansfont{TeX Gyre Heros}}% z. B. Overleaf
\setmonofont[Scale=MatchLowercase]{DejaVu Sans Mono}
\PassOptionsToPackage{main=\hsbi@sprache}{babel}
\RequirePackage[english, ngerman]{babel}% beide geladen, damit otherlanguage im Abstract geht
\RequirePackage[autostyle]{csquotes}
\RequirePackage[onehalfspacing]{setspace}
\RequirePackage[left=3cm, right=2cm, top=2cm, bottom=2cm,
                headheight=15pt, headsep=5mm, footskip=10mm]{geometry}
\RequirePackage{microtype}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{pdfpages}

% ---------- Überschriften: fett, klein, ohne Schlusspunkt ----------
\setkomafont{disposition}{\normalfont\bfseries}
\setkomafont{chapter}{\large}
\setkomafont{section}{\normalsize}
\setkomafont{subsection}{\normalsize}
\setkomafont{subsubsection}{\normalsize}
\RedeclareSectionCommand[beforeskip=-1sp, afterskip=.5\baselineskip,
  toclinefill=\TOCLineLeaderFill]{chapter}
\RedeclareSectionCommands[beforeskip=-.75\baselineskip, afterskip=.25\baselineskip]
  {section, subsection, subsubsection}
\setuptoc{toc}{totoc}% Inhaltsverzeichnis steht im Inhaltsverzeichnis (wie im Leitfaden)

% ---------- Kopfzeile mit Kapitelname, Seitenzahl unten rechts ----------
\RequirePackage[headsepline, singlespacing=true]{scrlayer-scrpage}
\clearpairofpagestyles
\automark[chapter]{chapter}
\ihead{\headmark}
\ofoot{\pagemark}
\setkomafont{pageheadfoot}{\small}
\renewcommand*{\chaptermarkformat}{\thechapter.\enskip}
\renewcommand*{\chapterpagestyle}{scrheadings}

% ---------- Abbildungen und Tabellen: fortlaufend, linksbündig ----------
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}
\setcaptionalignment{l}
% Verzeichniseinträge wie im Leitfaden: „Abbildung 1: Titel“
\newcommand*{\listoflolentryname}{\lstlistingname}
\BeforeStartingTOC[lof]{\renewcommand*{\numberline@postfix}{:\hfil}}
\BeforeStartingTOC[lot]{\renewcommand*{\numberline@postfix}{:\hfil}}
\BeforeStartingTOC[lol]{\renewcommand*{\numberline@postfix}{:\hfil}}
\deffootnote[1.5em]{1.5em}{1em}{\textsuperscript{\thefootnotemark}}

% ---------- Seitenzählung ----------
% Titelblatt + Abstract ohne Zahl, Verzeichnisse römisch ab I, Text arabisch ab 1,
% Literatur und Anhang römisch weiter nach den Verzeichnissen (Leitfaden 3.6).
\newcounter{hsbi@roemisch}
\AtBeginDocument{\pagenumbering{gobble}\hypersetup{pageanchor=false}}
\newcommand*{\verzeichnisteil}{\clearpage\pagenumbering{Roman}\hypersetup{pageanchor=true}}
\newcommand*{\hauptteil}{\clearpage\setcounter{hsbi@roemisch}{\value{page}}\pagenumbering{arabic}}
\newcommand*{\schlussteil}{\clearpage\pagenumbering{Roman}\setcounter{page}{\value{hsbi@roemisch}}}

% ---------- Titelblatt (Leitfaden Seite 1) ----------
\providecaptionname{ngerman}{\vorgelegtvonname}{vorgelegt von}
\providecaptionname{english}{\vorgelegtvonname}{submitted by}
\providecaptionname{ngerman}{\angefertigtname}{Angefertigt im}
\providecaptionname{english}{\angefertigtname}{Prepared in the}
\providecaptionname{ngerman}{\pruefername}{Prüferin oder Prüfer}
\providecaptionname{english}{\pruefername}{Examiner}
\providecaptionname{ngerman}{\erstpruefername}{Erstprüferin oder Erstprüfer}
\providecaptionname{english}{\erstpruefername}{First examiner}
\providecaptionname{ngerman}{\zweitpruefername}{Zweitprüferin oder Zweitprüfer}
\providecaptionname{english}{\zweitpruefername}{Second examiner}

\newcommand*{\arbeitstyp}[1]{\def\hsbi@arbeitstyp{#1}}
\newcommand*{\matrikelnummer}[1]{\def\hsbi@matrikelnummer{#1}}
\newcommand*{\studiengang}[1]{\def\hsbi@studiengang{#1}}
\newcommand*{\einrichtung}[1]{\def\hsbi@einrichtung{#1}}
\newcommand*{\semester}[1]{\def\hsbi@semester{#1}}
\newcommand*{\erstpruefer}[1]{\def\hsbi@erstpruefer{#1}}
\newcommand*{\zweitpruefer}[1]{\def\hsbi@zweitzeile{\\\zweitpruefername: & #1}}
\let\hsbi@zweitzeile\@empty

\renewcommand*{\maketitle}{%
  \begin{titlepage}
    \centering\large
    \rule{\textwidth}{0.4pt}\par
    \@title\par
    \vspace{\stretch{2}}
    \hsbi@arbeitstyp\par
    \vorgelegtvonname\par
    \@author\par
    \hsbi@matrikelnummer\par
    \bigskip
    \angefertigtname{} \hsbi@studiengang\par
    \vspace{\stretch{2}}
    \hsbi@einrichtung\par
    \bigskip\bigskip
    \hsbi@semester\par
    \vspace{\stretch{3}}
    {\small\singlespacing
     \begin{tabular}{@{}ll@{}}
       \ifx\hsbi@zweitzeile\@empty\pruefername\else\erstpruefername\fi:
         & \hsbi@erstpruefer\hsbi@zweitzeile
     \end{tabular}\par}
  \end{titlepage}}

% ---------- Literatur: Harvard (Autor-Jahr) ----------
\RequirePackage[backend=biber, style=ext-authoryear, autocite=inline,
  maxcitenames=2, maxbibnames=99, uniquename=false, giveninits=false,
  dashed=false, articlein=false, urldate=short, autolang=hyphen]{biblatex}
\DeclareNameAlias{sortname}{family-given}
\DeclareDelimFormat[bib]{nametitledelim}{\addcolon\space}
\DeclareFieldFormat{url}{[online]\space\url{#1}}
\DeclareFieldFormat{urldate}{\mkbibbrackets{#1}}
\DefineBibliographyStrings{ngerman}{bibliography = {Literaturverzeichnis}}

% ---------- Quellcode ----------
\RequirePackage{listings}
\lstset{
  basicstyle=\ttfamily\small\setstretch{1},
  numbers=left, numberstyle=\tiny\color{gray},
  frame=single, rulecolor=\color{gray},
  backgroundcolor=\color{black!3},
  keywordstyle=\bfseries, commentstyle=\color{black!60},
  breaklines=true, showstringspaces=false, keepspaces=true,
  numberbychapter=false,
}
\providecaptionname{ngerman}{\lstlistlistingname}{Listingverzeichnis}
\providecaptionname{english}{\lstlistlistingname}{List of Listings}

\RequirePackage[hidelinks, pdfusetitle]{hyperref}
\urlstyle{same}% URLs in der Textschrift wie im Leitfaden

% ---------- Abkürzungen ----------
\RequirePackage{array, longtable, acro}
\providecaptionname{ngerman}{\abkuerzungenname}{Abkürzungsverzeichnis}
\providecaptionname{english}{\abkuerzungenname}{List of Abbreviations}
\acsetup{
  make-links = true,
  list/template = longtable,
  list/heading = addchap,
  list/name = \abkuerzungenname,
  templates/colspec = {@{}w{l}{4.5cm}@{}p{\dimexpr\linewidth-4.5cm\relax}@{}},
}

% ---------- Eigenständigkeitserklärung (letzte Seite) ----------
% Hochschulweites Formular: https://www.hsbi.de/pruefungsangelegenheiten/hochschulweite-dokumente
\newcommand*{\erklaerung}{%
  \IfFileExists{erklaerung.pdf}
    {\includepdf[pages=-]{erklaerung.pdf}}
    {\clearpage\thispagestyle{empty}\raggedright
     \textbf{Eigenständigkeitserklärung}\par
     Platzhalter: Das hochschulweite Formular von
     \url{https://www.hsbi.de/pruefungsangelegenheiten/hochschulweite-dokumente}
     ausfüllen, unterschreiben und als \texttt{erklaerung.pdf} neben
     \texttt{main.tex} speichern.}}
