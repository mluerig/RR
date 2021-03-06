# -*- coding: utf-8 -*-
"""
Created on Tue Feb  6 14:30:39 2018

@author: Moritz
"""

# import some packages
import os
import pandas as pd

# for bokeh (and many other python packages) you need to specifically call the functions
from bokeh.io import show
from bokeh.layouts import row, column
from bokeh.models import Div, HoverTool, CustomJS, ColumnDataSource
from bokeh.plotting import figure, output_file



# specify your own workingdir, datainput, and output html
filename = "Sample_001a.txt"
main_dir = "E:\\GitHub\\RR\\plots\\"
data_dir = "E:\\GitHub\\RR\\data\\"
output_file(os.path.join(main_dir, os.path.splitext(filename)[0][0:11] + ".html"))

# load data
file = pd.read_csv(data_dir + filename,sep='\t', lineterminator='\r')
ds = ColumnDataSource(data=dict(file))

# specifiy tools
# there are many more (https://bokeh.pydata.org/en/latest/docs/user_guide/tools.html)
hover=HoverTool(
        tooltips = [
        ("ID", "@ID"),
        ("Pigmentation", "@Pigmentation"),
        ("Length", "@Length"),
])
div = Div(text="")

# this is a custom java function that pulls the original data (sub images) 
# make div (What is a "div" ? ->http://www.apaddedcell.com/what-div)
# uses custom java script - please don't ask me about it :-)
hover.callback = CustomJS(args=dict(div=div, ds=ds), code="""
    const hit_test_result = cb_data.index;
    const indices = hit_test_result._1d.indices;
    if (indices.length > 0) {
        div.text = `<img 
        src="${ds.data['Link'][indices[0]]}"
        height="550"width="350"
        style="float: left; margin: 0px 15px 15px 0px;"
        border="2"
        />`;
    }
""")


# make figure and layout in static html
p = figure(title=filename, 
           tools=['box_select', 'reset', 'zoom_in', 'zoom_out', 'box_zoom', "tap", hover]) 
           # these are the tools we want to include to interact with the responsive surface
p.scatter(x='Length', y='Pigmentation', source=ds, size=8)
layout = column(row(p, div))

# render html
show(layout)
