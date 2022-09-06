import requests
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
import re

base_url = "https://viperdb.scripps.edu"

all_tnums_url = "/services/tnumber_index.php?serviceName=tnumbers"
all_genuses_url = "/services/genus_index.php?serviceName=genus"
all_families_url = "/services/family_index.php?serviceName=families"

tnum_members_url = "/services/tnumber_index.php?serviceName=tnumber_members&tnumber="
genus_members_url = "/services/genus_index.php?serviceName=genus_members&genus="
family_members_url = "/services/family_index.php?serviceName=family_members&family="

rcsb_url = 'https://data.rcsb.org/rest/v1/core/entry/'
vdb_url = "https://viperdb.scripps.edu/"
radius_url = "services/biodata.php?serviceName=radius_formatted&VDB="

def getrcsb(c):
    res = requests.get(rcsb_url + c, verify=False)
    return res
def getrad(c):
    res = requests.get(vdb_url + radius_url + c, verify=False)
    return res

def tnum_url(n):
    return base_url + tnum_members_url + str(n)
def genus_url(g):
    return base_url + genus_members_url + g
def family_url(f):
    return base_url + family_members_url + f

#sort list of dictionaries by resolution and take the n lowest
def lowres_dictlist(dictlist, n):
    lowres = {}
    for k in dictlist.keys():
        sortres = sorted(dictlist[k], key=lambda d: (d['resolution'] is None, d['resolution']))
        lowres[k] = sortres[:n]
    return lowres
def dictlist(dictlist):
    res = {}
    for k in dictlist.keys():
        sortres = sorted(dictlist[k], key=lambda d: (d['resolution'] is None, d['resolution']))
        res[k] = sortres
    return res
