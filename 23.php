<?php

    $input = "jio a, +16
inc a
inc a
tpl a
tpl a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
tpl a
tpl a
inc a
jmp +23
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
tpl a
inc a
inc a
tpl a
inc a
tpl a
inc a
tpl a
inc a
inc a
tpl a
inc a
tpl a
tpl a
inc a
jio a, +8
inc b
jie a, +4
tpl a
inc a
jmp +2
hlf a
jmp -7";

    $instructions = explode("\n", $input);
    $a = 0;
    $b = 0;
    $i = 0;

    while ($i < count($instructions))
    {var_dump($i);
        $instr = explode(" ", str_replace(",", "", $instructions[$i]));
        $register = &${ $instr[1] };
        //var_dump($instr[0]);
        switch ($instr[0])
        {
            case 'hlf':
                $register /= 2;
                $i++;
                break;

            case 'tpl':
                $register *= 3;
                $i++;
                break;

            case 'inc':
                $register += 1;
                $i++;
                break;

            case 'jmp':
                $i += $instr[1] - 1;
                break;

            case 'jio'://var_dump("odd: ".$register);
                if($register % 2 != 0){ var_dump("odd: ".$i); $i += $instr[2] - 1; var_dump($i); }else{ $i++; }
                break;

            case 'jie'://var_dump("even: ".$register);
                if($register % 2 == 0){ var_dump($register); $i += $instr[2] - 1; }else{ $i++; }
                break;
        }
    }

    var_dump("-------------");
    var_dump("a: ".$a);
    var_dump("b: ".$b);