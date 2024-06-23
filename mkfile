<$PLAN9/src/mkhdr

TARG=acme
DIRS=mail

OFILES=\
	acme.$O\
	addr.$O\
	buff.$O\
	cols.$O\
	disk.$O\
	ecmd.$O\
	edit.$O\
	elog.$O\
	exec.$O\
	file.$O\
	fsys.$O\
	logf.$O\
	look.$O\
	regx.$O\
	rows.$O\
	scrl.$O\
	text.$O\
	time.$O\
	util.$O\
	wind.$O\
	xfid.$O\

HFILES=dat.h\
	edit.h\
	fns.h\
	config.h

<$PLAN9/src/mkone
<$PLAN9/src/mkdirs

edit.$O ecmd.$O elog.$O:	edit.h

likeplan9:V:
	mkdir -p likeplan9
	rm -f likeplan9/*
	for i in *.c
	do
		9 sed 's/->(fcall|lk|b|fr|ref|m|u|u1)\./->/g;
			s/\.(fcall|lk|b|fr|ref|m|u|u1)([^a-zA-Z0-9_])/\2/g
			s/&(([a-zA-Z0-9_]|->|\.)*)->(fcall|lk|b|fr|ref|m|u|u1)([^a-zA-Z0-9_])/\1\4/g
			s/range\(([^,()]+), ([^,()]+)\)/(Range){\1, \2}/g
		' $i >likeplan9/$i
	done

diffplan9:V:
	mk likeplan9
	9 diff -n plan9 likeplan9 | sed 's;likeplan9/;;'
