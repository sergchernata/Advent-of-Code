<?php

    $input = 'ckczppom';
    $pass = '';
    $i = 0;

    while(true)
    {
        $pass = md5($input.$i);
        if(substr($pass, 0, 6) === '000000'){ break; }else{ $i++; }
    }

    print $pass;
    print "<br/>";
    print $i;