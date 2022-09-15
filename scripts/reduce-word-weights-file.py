#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import pandas as pd
import glob
import re
from os.path import join
from os.path import basename
from os import rename

# this file serves to reduce the word-weights-output file of MALLET to just contain the weights for a certain number of top words of the topics but not for all the words
# just to reduce its size so that it can be processed more easily with XSLT and so that we can upload it to GitHub
# @author: Ulrike Henny-Krahmer


# read original word weights file
wdir = "/home/ulrike/Git/topic-model-tei/mallet-output"
infile = "word-weights_60tp-5000it-100in.csv"
num_topwords = 500
df = pd.read_csv(join(wdir, infile), sep="\t", index_col=None, header=None)
df_sorted = df.sort_values(by=[0, 2], ascending=False)
df_grouped = df_sorted.groupby([0])
df_top = df_grouped.head(num_topwords)

df_top.to_csv(join(wdir, "word-weights-reduced.csv"), sep="\t", header=False, index=False)


print("done")
