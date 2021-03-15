#!/usr/bin/awk -f
BEGIN{
    FS=",";
    outtoc="# 気象庁アメダス各地点観測表リンク集\n";
    outmain="";
}
{
    todofuken=$2;
    chiho="";
    if($2~/ /){
	chiho=todofuken;
	sub(/ .*/,"",todofuken);
	sub(/[^ ]* /,"",chiho);
    }
    if(prev_todofuken!=todofuken){
	prev_todofuken=todofuken;
	prev_chiho="";
	outtoc=outtoc"- ["todofuken"](#"todofuken")\n";
	outmain=outmain"# "todofuken"\n";
    }
    if(prev_chiho!=chiho){
	prev_chiho=chiho;
	outtoc=outtoc"-- ["chiho"](#"chiho")\n";
	outmain=outmain "## "chiho"\n";
    }
    chimei=$3;
    sub(/（.*/,"",chimei);
    outmain=outmain"["chimei"](https://www.jma.go.jp/bosai/amedas/#amdno="$1")\n";
}
END{
    print outtoc outmain;
}
