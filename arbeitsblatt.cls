\RequirePackage{cnltx-base}

\def\arbeitsblatt@version{0.0}
\def\arbeitsblatt@date{2013/11/01}
\def\arbeitsblatt@info{Klasse zum Erstellen von Arbeitsblaettern}

\ProvidesClass{arbeitsblatt}[%
  \arbeitsblatt@date\space
  \arbeitsblatt@version\space
  \arbeitsblatt@info\space (CN)]

\LoadClassWithOptions{scrartcl}

\cnltx@create@message*{arbeitsblatt}{Error}
\cnltx@create@message*{arbeitsblatt}{Warning}
\cnltx@create@message*{arbeitsblatt}{WarningNoLine}
\cnltx@create@message*{arbeitsblatt}{Info}

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
\cfoot{\small C.\,Niederberger -- aktualisiert am \today}

% exercises:
\let\vary\relax
\RequirePackage{exsheets}

% plots and other math graphics:
\RequirePackage{xcolor}
\colorlet{grid}{black!10}
\RequirePackage{tkz-fct,tkz-euclide}
\usetkzobj{all}

\endinput
