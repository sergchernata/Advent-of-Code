<?php

    $replacements = array("Al => ThF","Al => ThRnFAr","B => BCa","B => TiB","B => TiRnFAr","Ca => CaCa","Ca => PB","Ca => PRnFAr","Ca => SiRnFYFAr","Ca => SiRnMgAr","Ca => SiTh","F => CaF","F => PMg","F => SiAl","H => CRnAlAr","H => CRnFYFYFAr","H => CRnFYMgAr","H => CRnMgYFAr","H => HCa","H => NRnFYFAr","H => NRnMgAr","H => NTh","H => OB","H => ORnFAr","Mg => BF","Mg => TiMg","N => CRnFAr","N => HSi","O => CRnFYFAr","O => CRnMgAr","O => HP","O => NRnFAr","O => OTi","P => CaP","P => PTi","P => SiRnFAr","Si => CaSi","Th => ThCa","Ti => BP","Ti => TiTi","e => HF","e => NAl","e => OMg");
    $molecule = "CRnCaCaCaSiRnBPTiMgArSiRnSiRnMgArSiRnCaFArTiTiBSiThFYCaFArCaCaSiThCaPBSiThSiThCaCaPTiRnPBSiThRnFArArCaCaSiThCaSiThSiRnMgArCaPTiBPRnFArSiThCaSiRnFArBCaSiRnCaPRnFArPMgYCaFArCaPTiTiTiBPBSiThCaPTiBPBSiRnFArBPBSiRnCaFArBPRnSiRnFArRnSiRnBFArCaFArCaCaCaSiThSiThCaCaPBPTiTiRnFArCaPTiBSiAlArPBCaCaCaCaCaSiRnMgArCaSiThFArThCaSiThCaSiRnCaFYCaSiRnFYFArFArCaSiRnFYFArCaSiRnBPMgArSiThPRnFArCaSiRnFArTiRnSiRnFYFArCaSiRnBFArCaSiRnTiMgArSiThCaSiThCaFArPRnFArSiRnFArTiTiTiTiBCaCaSiRnCaCaFYFArSiThCaPTiBPTiBCaSiThSiRnMgArCaF";
    $combinations = array();

    function my_explode($delimiter, $string)
    {
        $d=array();
        $start = 0;

        while(strlen($string) > 0 && $delimiter)
        {
            $end = strpos($string, $delimiter);

            if($end !== false)
            {
                $slice = substr($string, $start, $end);

                if($slice !== ''){ array_push($d, $slice); }
                array_push($d, $delimiter);

                $string = substr($string, $end + strlen($delimiter));
            }
            else
            {
                array_push($d, $string);
                break;
            }
        }

        return empty($d) ? false : $d;
    }

    // first part
    foreach ($replacements as $r)
    {
        $r = explode(" => ", $r);
        $find = $r[0];
        $replace = $r[1];
        $parts = my_explode($find, $molecule);

        foreach ($parts as $k => $v)
        {
            if($find == $v)
            {
                $temp = $parts;
                $temp[$k] = $replace;
                $combo = implode($temp);

                if(!in_array($combo, $combinations))
                {
                    array_push($combinations, $combo);
                }
            }
        }
    }

    var_dump(count($combinations));

    //second part
    function my_sort($a, $b)
    {
        $a = strlen(explode(' => ', $a)[1]);
        $b = strlen(explode(' => ', $b)[1]);

        if ($a == $b) {
            return 0;
        }
        return ($a < $b) ? 1 : -1;
    }

    $steps = 0;
    $false = 0;
    usort($replacements, 'my_sort');

    while ($molecule != 'e')
    {
        foreach ($replacements as $r)
        {
            $r = explode(' => ', $r);

            $find = $r[1];
            $insert = $r[0];
            $parts = my_explode($find, $molecule);

            if($parts)
            {
                foreach ($parts as $pk => $pv)
                {
                    if($find == $pv)
                    {
                        $parts[$pk] = $insert;
                        $steps++;
                    }
                }

                $molecule = implode($parts);
            }
            else
            {
                $false++;
                continue;
            }

        }
    }

    var_dump($steps);
    var_dump($molecule);