#calculates speechrate & articulation rate 
clearinfo
path$ = "./"

listID = Create Strings as file list: "dateiListe", path$ + "*.TextGrid"

fileN = Get number of strings

for ifile from 1 to fileN
	selectObject: listID
	filename$ = Get string: ifile

	gridID = Read from file: path$ + filename$
	silbTier = 1
	dur = Get total duration
	pausDur = Get total duration of intervals where: silbTier, "starts with", "."
	artDur = dur - pausDur
	silbN = Count intervals where: silbTier, "does not start with", "."
	removeObject: gridID
	
	sprechrate = silbN / dur 
	artikulationsrate = silbN / artDur

	sprechrate = round(sprechrate * 100) / 100
	artikulationsrate = round(artikulationsrate * 100) / 100

	appendInfoLine: "Duration: ", dur, " [s], Syllables: ", silbN, " [silb], Speech rate: ", sprechrate, "[silb/s], Articulation rate: ", artikulationsrate, " [silb/s]"
endfor

removeObject: listID
