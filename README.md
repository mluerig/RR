# Interactive plotting

---

Hi!

**Please check the dowloads section first.**

**Update 1: if you want to see your own shiny app online register at http://www.shinyapps.io/ - it's free**

**Update 2: if you want to use rggobi you need to install the standalone program from http://www.ggobi.org/downloads/**


Everything I present will be referenced from this readme. I host all files and documents on github using 'github pages' (https://mluerig.github.io/RR/), so it's easiest if you **download this repository**

I hope that by the time of my talk this repository will be in a shape that allows you to run the code along with my presentation.

---

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [0) Downloads](#0-downloads)
- [1) Overview](#1-overview)
- [2) R: ggobi](#2-r-ggobi)
- [3) R: plotly](#3-r-plotly)
- [4) R: shiny](#4-r-shiny)
- [5) Python: bokeh](#5-python-bokeh)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

---



### 0) Downloads

**ggobi**

Download at http://www.ggobi.org/downloads/ and install. Then install the `rggobi package` (see below).

**R**

I assume you have R and Rstudio installed.
```
# required
install.packages(c("rggobi","ggplot2","shiny","plotly", "rmarkdown","knitr"))
# additional
install.packages(c("cowplot", "rgl"))

```

**Python (3.6)** 

Most of what we do happens in R, so you don't really need to install python (although I highly recommend it, e.g. https://conda.io/miniconda.html). Afterwards you can install packages from terminal using `conda install` (or `pip install`):

```
conda install os pandas bokeh
```
Rstudio can also interpret .py scripts. However, I will use the `spyder` IDE for python.    
```
conda install spyder
spyder
```



**Ready?**

![](https://media.giphy.com/media/XreQmk7ETCak0/giphy.gif)

**Good!**



### 1) Overview

There is an increasing amount of out-of-the-box solutions for interactive plotting that require only very little prior software or programming knowledge. This presentation has the goal to introduce you to a few of them, **all** opensource. 

Most of what we do today follows a similar pattern: interactive plots are generated by sending data through some existing plotting environment (e.g. `ggplot` in R or `matplotlib` in Python) and presenting the results in html. The result can be static (as in non-interactive Rmarkdown doctuments) or dynamic with interactive elements. Through code recursion an interactive experience is created: Reactive code (elements that respond to your input, e.g. a "slider") change the presented output. For details refer to the `shiny` tutorial, it nicely lays out some generalities of interactive plotting: http://rstudio.github.io/shiny/tutorial/#reactivity-overview

![](http://rstudio.github.io/shiny/tutorial/reactivity_diagrams/roles_implement.png)

The product can be a locally generated html document (can be embedded online, e.g.: http://luerig.net/rr_example1). Some companies like shiny or plotly offer host services that allow to publish "apps" (interactive figures) online with a single click: (e.g. https://luerig.shinyapps.io/Sample_001a).

Some examples with varying degrees of interactivity:

* https://www.r-graph-gallery.com/interactive-charts/
* https://www.r-graph-gallery.com/get-the-best-from-ggplotly/
* https://bokeh.pydata.org/en/latest/docs/gallery/les_mis.html
* https://shiny.rstudio.com/gallery/genome-browser.html
* https://plot.ly/r/datatable/


**We will now make some interactive plots using an isopod data set. We want to present pigmentation and body size of isopods from this scanned image:**

<img src="https://luerig.net/files/rr/Sample_001a.jpg">
---
### 2) R: ggobi

rggobi is the R implementation of GGobi (https://en.wikipedia.org/wiki/GGobi), a software originally designed to visualize and statistically evaluate multivariate data ("graphical MANOVA"). A comprehensive introduction is given here: http://www.ggobi.org/rggobi/introduction.pdf

**Load rggobi.R in the R subrepository**

Follow the instructions there 

---
### 3) R: plotly

**plotly** provides a set of tools that make responsive rather than interactive plots. You cannot - at least not without the support of additional code - change what you feed into the output, but rather manipulate what it shows.

**Load plotly.R in the R subrepository**

1) plotly has a neat function in R that allows you to make ggplot-objects responsive:

`ggplotly`

https://plot.ly/ggplot2/

2) There is also a native plotting function for R:

`plot_ly`

https://plot.ly/r/

3) From Rstudio you can export your interactive plots as html, e.g.: https://mluerig.github.io/RR/plots/iso_plotly.html


---
### 4) R: shiny

**R shiny apps** connect R code and wrap it into an html environment to enable the full reactivity pipeline shown above, i.e. you can not only select what you see, but what goes into the plot in the first place. This is a very powerful approach, essentially enabling non programming users to interact with the vast diversity of R generated graphics and data tables. Some of these apps can become very complex, check out the gallery: https://shiny.rstudio.com/gallery/

At the core of each shiny app are two components: a ui (user interface) that determines layout and control elements that are later presented in the dynamic html, and the server that includes the R code that actually does the job. Both are connected via internal code interfaces. Both components can be inside a single file, or each have a separate file, which makes more sense if you have a lot of code. We will work with the latter.

**Load ui.R and server.R from R subrepository**

1) We start with the server. Just imagine that you are writing a normal R document, with some additional elements. At the minimum we need to do three things:
* load the required packages
* data to feed the plot
* the plotting function (in this case again ggplot2)

The plotting function has to be wrapped in a reactive enviornment that will receive input from the ui.R, generate the plot, and send it back to the ui to display.

2) Open the ui file. You can already see that it looks different from a normal R file, it has a lot of layout wrapper functions, but when you study them more closely you can tell what they do:

```
pageWithSidebar #single page with a sidebar (meaning, that there has to be a main area)
  headerPanel # Panel on the top, for title (often has navigation buttons for multi page apps)
  sidebarPanel # This is the sidebar. In most app-examples the interactive elements are located here
    checkboxGroupInput # interactive element for input selection - from here stuff gets selected, and sent over as input$XXXXX to server
  mainPanel # here the plot from server gets displayed
```

That's basically it. Preview the app by clicking "Run app" in the upper right corner of the source panel. If it's working, you can publish it using the little blue symbol in Rstudio, on yourname.shinyapps.io/yourapp, and send it to your friends. They WILL like it!

---
### 5) Python: bokeh

**bokeh** is an relatively new platform to visualize large data quantities or data streams. At it's core, it is natively combining a responsive surface and plot surface interaction tools (as seen in plotly) with interactive elements that control data input as seen in shiny, e.g.: https://demo.bokehplots.com/apps/stocks. 

[For completness: it is possible to run plotly in a shiny app (https://plot.ly/r/shinyapp-linked-brush/) and shiny as well as plotly under python https://plot.ly/python/.]

Although available for R (http://hafen.github.io/rbokeh/#preview), bokeh unleashes its full power under python, where it is highly customizable and able to interface with other languages (custom html and java script snippets can be included). So, although still under development, bokeh is an extremely powerful toolbox for interactive graphics https://bokeh.pydata.org/en/latest/docs/gallery.html


**Open, but not run "bokeh/RR_bokeh_isopods.py" either with Rstudio or any python interpreter **

It rougly follows the generalities of what we have seen above:

1) load packages and data
2) chose type of plot and tools to include
3) render plot and push to html

Just click yourself through the elements.

I have included a custom java snipped that returns the original phenotypic data when hovering over each data point - try it.






