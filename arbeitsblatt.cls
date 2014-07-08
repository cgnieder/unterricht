% --------------------------------------------------------------------------
% the ARBEITSBLATT class v0.0
% 
%   A class for the creation of exercise sheets and small tutorial scripts
% 
% 2013/11/01
% --------------------------------------------------------------------------
% Clemens Niederberger
% Web:    https://github.com/cgnieder/unterricht/
% E-Mail: contact@mychemistry.eu
% --------------------------------------------------------------------------
% Copyright 2013-2014 Clemens Niederberger
% 
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
% 
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Clemens Niederberger.
% --------------------------------------------------------------------------
% The arbeitsblatt class consists of the files
%  - arbeitsblatt.cls,
%  - mathe-kl10.acro,
% --------------------------------------------------------------------------
% If you have any ideas, questions, suggestions or bugs to report, please
% feel free to contact me.
% --------------------------------------------------------------------------
\RequirePackage{cnltx-base}

\def\arbeitsblatt@version{0.0}
\def\arbeitsblatt@date{2013/11/01}
\def\arbeitsblatt@info{Klasse zum Erstellen von Arbeitsblaettern}

\ProvidesClass{arbeitsblatt}[%
  \arbeitsblatt@date\space
  \arbeitsblatt@version\space
  \arbeitsblatt@info\space (CN)]

\newbool{arb@loadfonts}
\booltrue{arb@loadfonts}
\newbool{arb@autotoc}
\booltrue{arb@autotoc}
\newbool{arb@babel}

\pgfkeys{
  arb/.cd ,
    load-fonts/.is if = arb@loadfonts ,
    auto-toc/.is if   = arb@autotoc ,
    babel/.code       =
      \booltrue{arb@babel}
      \def\arb@babel@options{#1} ,
    babel/.default    = ngerman ,
    .unknown/.code    =
      \expandafter\PassOptionsToClass\expandafter{\pgfkeyscurrentname}{scrartcl}
}

\ProcessPgfOptions{/arb}
\let\@classoptionslist\relax

\LoadClass{scrartcl}

\cnltx@create@message*{arb}{arbeitsblatt}{Error}
\cnltx@create@message*{arb}{arbeitsblatt}{Warning}
\cnltx@create@message*{arb}{arbeitsblatt}{WarningNoLine}
\cnltx@create@message*{arb}{arbeitsblatt}{Info}

\ifbool{arb@babel}{%
  \expandafter\RequirePackage\expandafter[\arb@babel@options]{babel}
}{}

\ifbool{arb@loadfonts}{
  % font setup:
  \RequirePackage[T1]{fontenc}
  \RequirePackage[oldstyle]{libertine}
  \csdef{libertine@figurestyle}{LF}
  \RequirePackage[libertine]{newtxmath}
  \csdef{libertine@figurestyle}{OsF}
  \RequirePackage[scaled=.81]{beramono}
}{}
% foornotes:
\ifbool{arb@loadfonts}{
  \RequirePackage[supstfm=libertinesups]{superiors}
  % libertine does not have superior letters:
  \def\@makefnmark{%
    \hbox{%
      \cnltx@ifisnum{\@thefnmark}
        {\textsu{\hspace*{\superiors@spaced}\@thefnmark}}
        {\@textsuperscript{\normalfont\@thefnmark}}%
    }%
  }
}{}
\deffootnote{2em}{1em}{\llap{\thefootnotemark. }}
\RequirePackage{fnpct}

% micro typography:
\ifbool{arb@loadfonts}{
  \RequirePackage[babel]{microtype}
  \DeclareMicrotypeSet[tracking]{scshape}{
    encoding = {*} ,
    shape    = {sc,scit,si}
  }
  \DeclareMicrotypeSet{romansans}{
    encoding = {*},
    family   = {rm*,sf*}
  }
  \microtypesetup{
    tracking   = scshape ,
    protrusion = romansans ,
    expansion  = romansans
  }
  \DisableLigatures{ family = tt* }
}{}
% now recalculate the typearea:
\recalctypearea

% floating material:
\setcapindent{1.5em}
\setkomafont{caption}{\normalfont\small\sffamily}
\setkomafont{captionlabel}{\normalfont\small\sffamily\scshape}
\RequirePackage{subcaption}

\csdef{fps@figure}{htb}
\csdef{fps@table}{htb}

% references:
\RequirePackage[ngerman]{varioref}

% tabular material:
\RequirePackage{array,booktabs,hhline}

% TODO: aktualisieren auf scrlayer-scrpage
% header/footer:
\RequirePackage{scrpage2}
\clearscrheadfoot
\pagestyle{scrheadings}
\chead{Seite \thepage}
\AtBeginDocument{%
  \cfoot{\small \@author\ -- aktualisiert am \@date}%
}

% exercises:
\let\vary\relax
\RequirePackage[load-headings]{exsheets}

% plots and other math graphics:
\RequirePackage{xcolor}
\colorlet{grid}{black!10}
\RequirePackage{tkz-fct,tkz-euclide,pgfplots}
\pgfplotsset{compat=newest}
\usetkzobj{all}

% title and the like:
\def\@title{?? Missing Title ??}
\def\@author{C.\,Niederberger}
\def\@date{\today}
\renewcommand*\title[1]{\gdef\@title{#1}}
\renewcommand*\author[1]{\gdef\@author{#1}}
\renewcommand*\date[1]{\gdef\@date{#1}}

\newbool{arb@abstract}
\newcommand\arb@abstract{}
\newcommand\setabstract[1]{%
  \booltrue{arb@abstract}%
  \renewcommand\arb@abstract{#1}%
}

\RequirePackage{multicol}
\renewcommand*\maketitle{%
  \begin{center}
    \Huge\sffamily\@title
  \end{center}%
  \let\title\@gobble
  \let\date\@gobble
  \let\author\@gobble
  \ifbool{arb@abstract}{%
    \begin{abstract}
      \arb@abstract
    \end{abstract}
  }{}%
  \ifbool{arb@autotoc}{%
    \begin{multicols}{2}[{\section*{\contentsname}\pdfbookmark[1]{\contentsname}{toc}}]
      \let\tocbasic@listhead\@gobble
      \tableofcontents
    \end{multicols}%
  }{}%
}

\renewcommand*\othersectionlevelsformat[3]{%
  \textcolor{cnltxblue}{#3\autodot}\enskip}
\renewcommand*\partformat{%
  \textcolor{cnltxblue}{\partname~\thepart\autodot}}

% math and chemistry related commands:
\RequirePackage{mathehelfer,chemiehelfer}

% example environment:
\RequirePackage[framemethod=tikz]{mdframed}
\colorlet{beispiel}{cnltxblue}
\newcounter{beispiel}
\newmdenv[
  linecolor  = beispiel ,
  linewidth  = .5ex ,
  rightline  = false ,
  leftline   = false ,
  frametitle = {\refstepcounter{beispiel}\textbf{Beispiel~\thebeispiel.}}
]{beispiel}

\newmdenv[
  frametitle = {\textbf{Info}}
]{info}

% tipp
\RequirePackage{marginnote,ragged2e,adjustbox}
\newcommand\tipp[1]{%
  \leavevmode
  \begingroup
    \reversemarginpar
    \marginnote
      {%
        \sffamily\small
        \IfFileExist{arb-lightbulb.pdf}{%
          \adjustbox{valign=B,center=\marginparwidth,set vsize={0pt}{0pt}}{%
            \includegraphics{arb-lightbulb.pdf}%
          }\newline
        }{}%
        \RaggedRight\textcolor{cnltxgray}{#1}%
      }[-\baselineskip]%
    \endgroup
}

% definitions:
\newmdenv[
  % backgroundcolor = red!20,
  % hidealllines    = true,
  linecolor       = cnltxred ,
  leftmargin      = 2em ,
  rightmargin     = 2em ,
  skipabove       = \baselineskip ,
  skipbelow       = \baselineskip ,
  frametitle      = Definition ,
  frametitlefont  = \large\sffamily\scshape ,
  frametitlebackgroundcolor = cnltxred!40
]{definition}

% acronyms abused as some kind of glossary:
\newrobustcmd\saveat{%
  \edef\resetat{%
    \catcode\number`\@=\number\catcode`\@%
    \def\noexpand\resetat{}%
  }%
}
\newcommand*\resetat{}

\newrobustcmd*\siehe{$\rightarrow$\nobreakspace}
\newrobustcmd*\begriff{\siehe\acs}
\newrobustcmd*\begriffa{\siehe\aca}
\newrobustcmd*\begriffp{\siehe\acp}
% currently there is one definition file, mathe-kl10.acro
\newrobustcmd*\loadacronyms[1]{%
  \saveat
  \shorthandon{"}%
  \useshorthands{"}%
  \makeatletter
  \input{#1.acro}%
  \shorthandoff{"}%
  \resetat
}
\@onlypreamble\loadacronyms

\AtBeginDocument{%
  \RequirePackage{hyperref}
  \hypersetup{
    colorlinks = false ,
    pdftitle = {\@title}
  }%
}

\newrobustcmd\setarbeitsblatt[1]{%
  \pgfqkeys{/arb}{#1}%
}

\endinput
HISTORY:
2013/11/01 v0.0 - initial draft
2014/07/08 v0.1 - Code in 'mathehelfer' und `chemiehelfer' ausgelagert

TODO:
- Option, mit denen Mathe/Chemie-Pakete optional geladen werden können
- Option, mit der man die automatische Font-Wahl abschalten kann
- Doku schreiben

