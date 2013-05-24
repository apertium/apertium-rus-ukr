#!/usr/bin/env python3

#import xml.etree.ElementTree as etree
import os
import sys
import re
from lxml import etree

if len(sys.argv) < 3:
#	print("Usage: %s corpus_dir output_file" % sys.argv[0])
	print("Usage: %s corpus_file output_file" % sys.argv[0])
	sys.exit()

output = open(sys.argv[2], 'w')
#os.chdir(sys.argv[1])
#files = os.listdir('.')
#
#xmlFile = re.compile(".*\.xml$")
#
#for fn in files:
#	if xmlFile.match(fn):
#		print("Adding content from "+fn)
#		root = etree.parse(fn).getroot()
#		for item in root.getiterator("{http://apertium.org/xml/corpus/0.9}entry"):
#			output.write(item.attrib['title']+'\n'+item.text+'\n\n')

fn = sys.argv[1]
print("Adding content from "+fn)
root = etree.parse(fn).getroot()
for item in root.getiterator("{http://apertium.org/xml/corpus/0.9}entry"):
	output.write(item.attrib['title']+'\n'+item.text+'\n\n')

output.close()
print("Done.")
