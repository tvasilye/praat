clearinfo
path$ = "./"
floor = 90
ceiling = 400
silbTier = 1

#writeFileLine: "myFile.txt", "Name 'tab$'pitch[Hz]'tab$'amMdF0b[Hz]'tab$'amMdF0u[Hz]"
writeInfoLine: "Name 'tab$'MD(all)[Hz]'tab$'amMdF0b[Hz]'tab$'amMdF0u[Hz]"

listID = Create Strings as file list: "dateiListe", path$ + "*.wav"
fileN = Get number of strings

for ifile from 1 to fileN
	selectObject: listID
	fileName$ = Get string: ifile
	wavID = Read from file: path$ + fileName$
	piID = To Pitch (ac): 0, floor, 15, "yes", 0.03, 0.45, 0.01, 0.35, 0.14, ceiling

	mdPi = Get quantile: 0, 0, 0.5, "Hertz"
	mdPi = round(mdPi)

	sumbMdF0 = 0
	sumuMdF0 = 0
	bN = 0
	uN = 0

	name$ = fileName$ - ".wav"
	text_name$ = name$ + ".TextGrid"
	gridID = Read from file: path$ + text_name$
	intN = Get number of intervals: silbTier

	for iint to intN
		selectObject: gridID

		intName$ = Get label of interval: silbTier, iint
		anf = Get start time of interval: silbTier, iint
		end = Get end time of interval: silbTier, iint

		selectObject: piID 
		mdF0 = Get quantile: anf, end, 0.5, "Hertz"

		if intName$ == "u" and mdF0<>undefined
			uN += 1
			sumuMdF0 += mdF0
		elsif intName$ == "b" and mdF0<>undefined
			bN += 1
			sumbMdF0 += mdF0
		endif

	endfor

	amMdF0u = round(sumuMdF0 / uN)
	amMdF0b = round(sumbMdF0 / bN)

	#appendFileLine: "myFile.txt", "'name$'tab$'mdPi'tab$'amMdF0b'tab$'amMdF0u'"
	appendInfoLine: name$, tab$, mdPi, tab$, amMdF0b, tab$, amMdF0u

	removeObject: gridID
	removeObject: wavID
	removeObject: piID

endfor
removeObject: listID
