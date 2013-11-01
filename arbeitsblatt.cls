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
% \RequirePackage[T1]{fontenc}
% \RequirePackage[utf8]{inputenc}

% font setup:
\RequirePackage[oldstyle]{libertine}
\csdef{libertine@figurestyle}{LF}
\RequirePackage[libertine]{newtxmath}
\csdef{libertine@figurestyle}{OsF}
\RequirePackage{microtype}
\recalctypearea

% figures and tables:
\setcapindent{1.5em}
\setkomafont{caption}{\normalfont\small\sffamily}
\setkomafont{captionlabel}{\normalfont\small\sffamily\scshape}

\csdef{fps@figure}{htb}
\csdef{fps@table}{htb}

% \RequirePackage{silence}
% \WarningFilter{microtype}{I cannot find a protrusion list}

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

\AtBeginDocument{%
  \RequirePackage{hyperref}
  \hypersetup{
    colorlinks = false ,
    pdftitle = {\@title}
  }%
}

\endinput
