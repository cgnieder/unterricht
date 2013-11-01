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

% math related commands:
\RequirePackage{amsmath,amssymb,siunitx}
\sisetup{locale=DE}
\DeclareMathOperator\asin{sin^{-1}}
\DeclareMathOperator\acos{cos^{-1}}
\DeclareMathOperator\atan{tan^{-1}}
\newcommand*\menge[1]{\mathbb{#1}}
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

\newcommand*\auftrag[1]{{}\mid#1}

\ExplSyntaxOn
\cs_new_protected:Npn \berechne #1
  {
    \group_begin:
      \sisetup{round-mode=places,round-precision=2}
      \exp_args:Nx \num { \fp_eval:n { #1 } }
    \group_end:
  }
\ExplSyntaxOff

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

\AtBeginDocument{%
  \RequirePackage{hyperref}
  \hypersetup{
    colorlinks = false ,
    pdftitle = {\@title}
  }%
}

\endinput
