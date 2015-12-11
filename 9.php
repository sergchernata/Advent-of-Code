<?php

$input = 'Tristram to AlphaCentauri = 34
            Tristram to Snowdin = 100
            Tristram to Tambi = 63
            Tristram to Faerun = 108
            Tristram to Norrath = 111
            Tristram to Straylight = 89
            Tristram to Arbre = 132
            AlphaCentauri to Snowdin = 4
            AlphaCentauri to Tambi = 79
            AlphaCentauri to Faerun = 44
            AlphaCentauri to Norrath = 147
            AlphaCentauri to Straylight = 133
            AlphaCentauri to Arbre = 74
            Snowdin to Tambi = 105
            Snowdin to Faerun = 95
            Snowdin to Norrath = 48
            Snowdin to Straylight = 88
            Snowdin to Arbre = 7
            Tambi to Faerun = 68
            Tambi to Norrath = 134
            Tambi to Straylight = 107
            Tambi to Arbre = 40
            Faerun to Norrath = 11
            Faerun to Straylight = 66
            Faerun to Arbre = 144
            Norrath to Straylight = 115
            Norrath to Arbre = 135
            Straylight to Arbre = 127';

        $string = 0;
        $memory = 0;
        $locations = array();
        $direct = array();
        $paths = array();

        $arr = explode("\r\n", $input);//var_dump($arr);

        foreach ($arr as $a)
        {
            $temp = explode(" = ", $a);
            $direct[$temp[0]] = $temp[1];
            $temp = explode(" to ", $temp[0]);
            if(!in_array($temp[0], $locations)){ array_push($locations, $temp[0]); }
            if(!in_array($temp[1], $locations)){ array_push($locations, $temp[1]); }
        }

        function find_paths($all_locations, $direct, $from, $paths = array())
        {
            // reset keys & pick the new 'from'
            array_values($all_locations);
            if(!isset($paths['total'])){ $paths['total'] = 0; }

            // exclude the current 'from' and create new set
            $temp = $all_locations;
            if(($key = array_search($from, $temp)) !== false) { unset($temp[$key]); }//else{ var_dump($temp); var_dump($from); }
            $temp = array_values($temp);
            $possible = array();
            $to = '';

            foreach ($direct as $k => $v)
            {
                if(strpos($k, $from) !== false && in_array(str_replace(array($from, ' to '),"",$k), $temp))
                {
                    $to = str_replace(array($from, ' to '),"",$k);
                    $possible[$from.' to '.$to] = $v;
                }
            }

            if(!empty($possible))
            {
                //var_dump(array_keys($possible, min($possible)));
                $smallest_key = array_keys($possible, max($possible));
                $smallest_value = $possible[$smallest_key[0]];
                $paths[$smallest_key[0]] = $smallest_value;
                $paths['total'] += $smallest_value;
                $to = trim(str_replace(array($from, ' to '),"",$smallest_key[0]));

                if(count($temp) > 0)
                {
                    return find_paths($temp, $direct, $to, $paths);
                }
            }
            else
            {
                return $paths;
            }
        }

        foreach ($locations as $l)
        {
            $i = 0;
            $paths[$l] = array();
            $temp = $locations;
            if(($key = array_search($l, $temp)) !== false) { unset($temp[$key]); }
            $temp = array_values($temp);//var_dump($temp);
            $nothing_found = 0;
            $from = $l;

            $paths[$l] = find_paths($locations, $direct, $l);
        }

        var_dump($paths);