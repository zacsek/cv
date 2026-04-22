\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{zaxCv}[2024/06/26 Zax CV class v1.0]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}} % Pass through any options to the base class
\ProcessOptions\relax % Process given options
\LoadClass{extarticle} % Load the base class

%----------------------------------------------------------------------------------------
%	PACKAGES AND OTHER DOCUMENT CONFIGURATIONS
%----------------------------------------------------------------------------------------

\setlength{\parindent}{0mm} % Suppress paragraph indentation

\usepackage[hidelinks]{hyperref} % Required for links but hide the default boxes around links

\pagestyle{empty} % No headers or footers

\usepackage{moresize} % Provides more font size commands (\HUGE and \ssmall)
\usepackage{enumitem}
%----------------------------------------------------------------------------------------
%	PAGE LAYOUT
%----------------------------------------------------------------------------------------

\usepackage{geometry} % Required for adjusting page dimensions and margins

\geometry{
  paper=a4paper, % Paper size, change to letterpaper for US letter size
  top=1.6cm, % Top margin
  bottom=1.6cm, % Bottom margin
  left=1.6cm, % Left margin
  right=1.6cm, % Right margin
  headheight=0.75cm, % Header height
  footskip=1cm, % Space from the bottom margin to the baseline of the footer
  headsep=0.5cm, % Space from the top margin to the baseline of the header
  %showframe, % Uncomment to show how the type block is set on the page
  }

  %----------------------------------------------------------------------------------------
  %	FONTS
  %----------------------------------------------------------------------------------------

  \usepackage[utf8]{inputenc} % Required for inputting international characters
  \usepackage[T1]{fontenc} % Output font encoding for international characters

  \usepackage[default]{raleway}
  %\usepackage[defaultsans]{droidsans}
  %\usepackage{cmbright}

  \renewcommand*\familydefault{\sfdefault} % Force the sans-serif version of any font used

  %------------------------------------------------

  \usepackage{fontawesome} % Required for FontAwesome icons

  % Command to output an icon in a black square box with text to the right
  \newcommand{\icon}[3]{% The first parameter is the FontAwesome icon name, the second is the box size and the third is the text
    \vcenteredhbox{
      \colorbox{white}{
        \makebox(#2, #2){
          \textcolor{black}{
            \Large\csname fa#1\endcsname
          }
        }
      }
    }% Icon and box
    \hspace{0.1cm}% Whitespace
    \vcenteredhbox{\textcolor{black}{#3}}% Text
  }
