#script to check the downlaods and give them sensible names
import pandas as pd
import os
import re

top_level = "/home/annbrown/alb_projects/data/herzog_2017/"
xpo05 = os.listdir(os.path.join(top_level,"xpo5_ko"))
mettl3_ko = os.listdir(os.path.join(top_level,"mettl3_ko"))

sra_check_xpo05 = pd.read_csv(os.path.join(top_level,"SraRunTable_xpo5_ko.txt"),sep = "\t")

sra_xpo05_missing = []
for sra in sra_check_xpo05.Run.tolist():
	if sra in [re.sub(".fastq","",r) for r in xpo05]:
		print(sra)
		print(sra_check_xpo05.loc[sra_check_xpo05["Run"] == sra].source_name.tolist()[0])
		org = top_level + "xpo5_ko/" + sra + ".fastq"
		new = top_level + "xpo5_ko/" + sra_check_xpo05.loc[sra_check_xpo05["Run"] == sra].source_name.tolist()[0] + ".fastq"
		os.rename(org,new)
	#if it was previously renamed
	elif sra_check_xpo05.loc[sra_check_xpo05["Run"] == sra].source_name.tolist()[0] in [re.sub(".fastq","",r) for r in xpo05]:
		continue
	else:
		sra_xpo05_missing.append(sra)

if sra_xpo05_missing == []:
	print("nothing missing in xpo05")
else:
	with open(top_level + "sra_xpo05_missing.txt", 'w') as f:
		for item in sra_xpo05_missing:
			f.write("%s\n" % item)

sra_check_mettl3 = pd.read_csv(os.path.join(top_level,"SraRunTable_mettl3_ko.txt"),sep = "\t")

sra_mettl3_missing = []
for sra in sra_check_mettl3.Run.tolist():
	if sra in [re.sub(".fastq","",r) for r in mettl3_ko]:
		print(sra)
		print(sra_check_mettl3.loc[sra_check_mettl3["Run"] == sra].source_name.tolist()[0])
		org = top_level + "mettl3_ko/" + sra + ".fastq"
		new = top_level + "mettl3_ko/" + sra_check_mettl3.loc[sra_check_mettl3["Run"] == sra].source_name.tolist()[0] + ".fastq"
		os.rename(org,new)
	elif sra_check_mettl3.loc[sra_check_mettl3["Run"] == sra].source_name.tolist()[0] in [re.sub(".fastq","",r) for r in mettl3_ko]:
		continue
	else:
		sra_mettl3_missing.append(sra)

if sra_mettl3_missing == []:
	print("nothing missing in mettl3")
else:
	with open(top_level + "sra_mettl3_missing.txt", 'w') as f:
		for item in sra_mettl3_missing:
			f.write("%s\n" % item)