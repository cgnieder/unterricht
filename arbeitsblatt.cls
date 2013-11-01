% --------------------------------------------------------------------------
% the ARBEITSBLATT class v0.0
% 
%   A class for the creation of exercise sheets and small tutorial scripts
% 
% 2013/11/01
% --------------------------------------------------------------------------
% Clemens Niederberger
% Web:    https://bitbucket.org/cgnieder/unterricht/
% E-Mail: contact@mychemistry.eu
% --------------------------------------------------------------------------
% Copyright 2013 Clemens Niederberger
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

\LoadClassWithOptions{scrartcl}

\cnltx@create@message*{arb}{arbeitsblatt}{Error}
\cnltx@create@message*{arb}{arbeitsblatt}{Warning}
\cnltx@create@message*{arb}{arbeitsblatt}{WarningNoLine}
\cnltx@create@message*{arb}{arbeitsblatt}{Info}

\RequirePackage[ngerman]{babel}

% font setup:
\RequirePackage[oldstyle]{libertine}
\csdef{libertine@figurestyle}{LF}
\RequirePackage[libertine]{newtxmath}
\csdef{libertine@figurestyle}{OsF}

% foornotes:
\RequirePackage[supstfm=libertinesups]{superiors}
% libertine does not have superior letters:
\def\@makefnmark{%
  \hbox{%
    \cnltx@ifisnum{\@thefnmark}
      {\textsu{\hspace*{\superiors@spaced}\@thefnmark}}
      {\@textsuperscript{\normalfont\@thefnmark}}%
  }%
}
\deffootnote{2em}{1em}{\llap{\thefootnotemark. }}
\RequirePackage{fnpct}

% micro typography:
\RequirePackage{microtype}

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
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}

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
\RequirePackage{exsheets}

% plots and other math graphics:
\RequirePackage{xcolor}
\colorlet{grid}{black!10}
\RequirePackage{tkz-fct,tkz-euclide}
\usetkzobj{all}

% title and the like:
\def\@title{?? Missing Title ??}
\def\@author{C.\,Niederberger}
\def\@date{\today}
\renewcommand*\title[1]{\gdef\@title{#1}}
\renewcommand*\author[1]{\gdef\@author{#1}}
\renewcommand*\date[1]{\gdef\@date{#1}}

\renewcommand*\maketitle{%
  \begin{center}
    \Huge\sffamily\@title
  \end{center}%
  \let\title\@gobble
  \let\date\@gobble
  \let\author\@gobble
}

\renewcommand*\othersectionlevelsformat[3]{%
  \textcolor{cnltxblue}{#3\autodot}\enskip}
\renewcommand*\partformat{%
  \textcolor{cnltxblue}{\partname~\thepart\autodot}}

% math and chemistry related commands:
\RequirePackage{amsmath,amssymb,siunitx,chemmacros}
\sisetup{locale=DE}

\DeclareMathOperator\asin{sin^{-1}}
\DeclareMathOperator\acos{cos^{-1}}
\DeclareMathOperator\atan{tan^{-1}}

% 
\newcommand*\menge[1]{\mathbb{#1}}
\newcommand*\natuerliche     {\menge{N}}
\newcommand*\ganze           {\menge{Z}}
\newcommand*\rationale       {\menge{Q}}
\newcommand*\irrationale     {\menge{I}}
\newcommand*\reelle          {\menge{R}}
\newcommand*\komplexe        {\menge{C}}
\newcommand*\definitionsmenge{\menge{D}}
\newcommand*\wertemenge      {\menge{W}}

% \punkt*(x,y) or \punkt*(x,y,z)
% \punkt{A}(x,y) or \punkt{A}(x,y,z)
\newcommand*\punkt{\@ifstar{\@punkt}{\@Punkt}}
\newcommand*\@Punkt[1]{#1\@punkt}
\newcommand*\@punkt{}
\def\@punkt(#1){\@punkt@aux#1,,\q@stop}
\def\@punkt@aux#1,#2,#3,#4\q@stop{%
  \ifblank{#3}
    {\@punkt@RR{#1}{#2}}
    {\@punkt@RRR{#1}{#2}{#3}}%
}
\newcommand*\@punkt@RR[2]{(\,#1\mid#2\,)}
\newcommand*\@punkt@RRR[3]{(\,#1\mid#2\mid#3\,)}

% Arbeitsstrich:
\newcommand*\auftrag[1]{{}\mid#1}

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

% acronyms abused as some kind of glossary:
\newrobustcmd\saveat{%
  \edef\resetat{%
    \catcode\number`\@=\number\catcode`\@%
    \def\noexpand\resetat{}%
  }%
}
\newcommand*\resetat{}

\newcommand*\siehe{$\rightarrow$~}
\newcommand*\begriff{\siehe\ac}
\newcommand*\begriffa{\siehe\aca}
% currently there is one definition file, mathe-kl10.acro
\newrobustcmd*\loadacronyms[1]{%
  \saveat
  \makeatletter
  \input{#1.acro}%
  \resetat
}

\AtBeginDocument{%
  \RequirePackage{hyperref}
  \hypersetup{
    colorlinks = false ,
    pdftitle = {\@title}
  }%
}

\endinput
HISTORY:
2013/11/01 v0.0 - initial draft

TODO:
- Option, mit denen Mathe/Chemie-Pakete optional geladen werden können
- Option, mit der man die automatische Font-Wahl abschalten kann
- Doku schreiben

