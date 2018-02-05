# -*- coding: utf-8 -*-
"""
Created on Mon Nov 13 08:47:42 2017

@author: Moritz
"""
import os
import pandas as pd

from bokeh.io import show
from bokeh.layouts import row, column
from bokeh.models import Div, HoverTool, CustomJS, ColumnDataSource
from bokeh.plotting import figure, output_file

filename = "Sample_001a"
main = "E:\\Python_wd1\\2018_RR_bokeh\\"
output_file(os.path.join(main, filename + ".html"))

file = pd.read_csv(main + filename + "_processed_2.txt",sep='\t', lineterminator='\r')
ds = ColumnDataSource(data=dict(file))


hover=HoverTool()
div = Div(text="")

hover.callback = CustomJS(args=dict(div=div, ds=ds), code="""
    const hit_test_result = cb_data.index;
    const indices = hit_test_result._1d.indices;
    if (indices.length > 0) {
        div.text = `<img src="${ds.data['Link'][indices[0]]}"/>`;
    }
""")


p = figure(title=filename, tools=[hover]) #, x_range=x_factor
p.scatter(x='Length', y='Pigmentation', source=ds, size=8)

layout = column(row(p, div))

show(layout)

