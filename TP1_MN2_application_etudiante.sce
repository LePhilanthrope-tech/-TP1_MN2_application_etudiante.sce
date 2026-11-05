\documentclass[11pt,a4paper]{article}
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage[french]{babel}
\usepackage{lmodern,amsmath,booktabs,geometry,hyperref}
\geometry{margin=2cm}
\setlength{\parindent}{0pt}
\setlength{\parskip}{4pt}
\begin{document}
\begin{center}
{\Large\bfseries Méthodes numériques 2 -- TP1}\\
 \ Membres : BAYALA Grace Deinyini Orlane (20230225), DAMIBA Yemboini Ismaël (20220384), YOUMBI TABUE Miguel Jonathan (20240142)\\
Enseignant : Babacar LEYE\end{center}


\section*{Objectif et données}
Deux situations sont étudiées avec les routines du CM1 (\texttt{trapezes}, \texttt{simpson}, \texttt{echantillonner}, \texttt{ordre\_observe}).

\textbf{Cas continu de contrôle.} $f(x)=e^x$ sur $[0,1]$ (modèle normalisé, sans unité), de référence exacte $I_{\text{ref}}=e-1\approx1{,}718281828$. Elle permet de mesurer erreurs et ordres.

\textbf{Pompe.} Cinq relevés (temps en min, puissance en kW) :
\begin{center}\small
\begin{tabular}{lccccc}
\toprule
$t$ (min) & 0 & 10 & 20 & 30 & 40\\
$P$ (kW) & 2,0 & 2,6 & 3,0 & 2,5 & 1,9\\
\bottomrule
\end{tabular}
\end{center}
Chaque lecture a une incertitude d'au plus $0{,}1$ kW. Les temps sont convertis en heures ($t_h=t_{\min}/60$) pour obtenir des kWh.

\section*{Méthode et contrôles}
Pour un pas $h$ uniforme : $T_n=\frac h2\big[f_0+f_n+2\sum_{i=1}^{n-1}f_i\big]$ et $S_n=\frac h3\big[f_0+f_n+4\sum_{i\ \text{impair}}f_i+2\sum_{i\ \text{pair},\,0<i<n}f_i\big]$. Les trapèzes acceptent des pas inégaux ; Simpson exige $n$ pair et des pas égaux. Cas continu : $n\in\{4,8,16,32\}$, soit $5,\,9,\,17,\,33$ évaluations de $f$.

\textbf{Contrôle du CM1} ($P(t)=10+4t-t^2$ W aux temps $0,1,2,3,4$ s) : $T_4=50$ J et $S_4=152/3\approx50{,}667$ J, valeur exacte. Les routines sont validées (Simpson refuse aussi les pas inégaux et un $n$ impair). Ce contrôle ne valide pas les mesures de la pompe.

\section*{Résultats et ordres}
$E_n=|Q_n-I_{\text{ref}}|$ et $p=\log(E_n/E_{2n})/\log2$ (ligne $n$ $\to$ ligne suivante).
\begin{center}
\small
\begin{tabular}{rrrrrrr}
\toprule
$n$&$T_n$&$S_n$&$E_n(T)$&$E_n(S)$&$p(T)$&$p(S)$\\
\midrule
4 &1,727221905&1,718318842&$8{,}94\cdot10^{-3}$&$3{,}70\cdot10^{-5}$&1,999&3,992\\
8 &1,720518592&1,718284155&$2{,}24\cdot10^{-3}$&$2{,}33\cdot10^{-6}$&2,000&3,998\\
16&1,718841129&1,718281974&$5{,}59\cdot10^{-4}$&$1{,}46\cdot10^{-7}$&2,000&3,999\\
32&1,718421660&1,718281838&$1{,}40\cdot10^{-4}$&$9{,}10\cdot10^{-9}$&--&--\\
\bottomrule
\end{tabular}
\end{center}
\textbf{Tendance.} Les ordres tendent vers $2$ (trapèzes) et $4$ (Simpson), comme prévu au CM1 : doubler $n$ divise l'erreur par $4$, respectivement $16$. Le régime asymptotique est atteint, et les erreurs mesurées à $n=4$ concordent avec les formules théoriques ($\approx8{,}95\cdot10^{-3}$ et $3{,}73\cdot10^{-5}$).

\textbf{Limites.} Si $E_n=0$ ou si l'erreur approche l'arrondi machine ($\sim10^{-16}$), le quotient $E_n/E_{2n}$ n'a plus de sens (division par zéro, bruit d'arrondi) : \texttt{ordre\_observe} renvoie alors \texttt{\%nan}. L'ordre suppose aussi une fonction lisse et une référence exacte. On ne calcule donc \emph{aucun} ordre avec les cinq relevés de la pompe : ni maillages emboîtés, ni référence.

\textbf{Pompe} ($h=1/6$ h, $n=4$) :
$T_4=1{,}675000$ kWh, $S_4=1{,}683333$ kWh, écart $=0{,}008333$ kWh.

\section*{Décision et limites}
\textbf{Énergie communiquée :} $E\approx1{,}7$ kWh (valeurs de calcul $1{,}675$ à $1{,}683$ kWh). Les lectures seules peuvent la modifier de $0{,}1\times40/60\approx0{,}067$ kWh, soit environ $\pm0{,}07$ kWh au minimum ; les décimales supplémentaires n'ont pas de sens physique.

\textbf{Comparaison.} L'écart entre méthodes ($0{,}0083$ kWh) est environ $8$ fois plus petit que cette borne : le choix de la quadrature est négligeable devant l'incertitude de mesure. On ne peut donc pas affirmer que Simpson donne l'énergie réelle la plus juste : son bon ordre sur $e^x$ ne prouve rien sur une courbe inconnue.

\textbf{Ce que les relevés ne permettent pas de vérifier.} Avec un relevé toutes les 10 min, un pic de démarrage, une baisse brève, un arrêt-redémarrage ou un cycle plus court que 20 min peuvent passer entre deux mesures. Simpson n'« invente » pas ces variations. Pour le savoir, il faudrait des relevés plus rapprochés et des capteurs plus précis.

\section*{Reproductibilité}
Lien du dépôt GitHub accessible à l'enseignant : \url{}
\par Identifiant du commit utilisé : \ldots
\end{document}
