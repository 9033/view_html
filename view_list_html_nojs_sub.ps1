echo off
chcp 65001
$outputfile="view_list_no-js.html"
function htmlhead{
    echo "<!DOCTYPE html><html><head><meta charset=""UTF-8""><style>p{font-size:50px;} body{background-color:#888888;color:white;}</style></head><body><p id=""root_tag""></p>" > $outputfile
}
function imgtagging{
    $files=(Get-ChildItem -Name *.jpg,*.jpeg,*.gif,*.png) | sort
    foreach ($f in $files){
        echo "<img src=""$f""><br>"  >> $outputfile
    }
}
function videotagging($ext){
    #webm, mp4
    $files=(Get-ChildItem -Name ("*."+$ext)) | sort
    foreach ($f in $files){        
        echo "<video controls><source src=""$f"" type=""video/$ext""></video><br>" >> $outputfile
    }
}
function htmltale{
    echo "</body></html>"  >> $outputfile
}
function genhtml{
    htmlhead
    $dirs=(Get-ChildItem -Directory -Name) | sort
    foreach ($d in $dirs){
        echo "<a href=""$d\$outputfile"">$d</a><br>"  >> $outputfile
    }
    imgtagging
    videotagging("webm")
    videotagging("mp4")
    htmltale
    
    foreach ($d in $dirs){
        cd $d
        genhtml
        cd ..
    }
}

genhtml
