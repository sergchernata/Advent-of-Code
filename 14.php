<?php        
        $input  ="Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
Cupid can fly 22 km/s for 2 seconds, but then must rest for 41 seconds.
Rudolph can fly 11 km/s for 5 seconds, but then must rest for 48 seconds.
Donner can fly 28 km/s for 5 seconds, but then must rest for 134 seconds.
Dasher can fly 4 km/s for 16 seconds, but then must rest for 55 seconds.
Blitzen can fly 14 km/s for 3 seconds, but then must rest for 38 seconds.
Prancer can fly 3 km/s for 21 seconds, but then must rest for 40 seconds.
Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
Vixen can fly 18 km/s for 5 seconds, but then must rest for 84 seconds.";

        $deer = explode("\n", $input);
        $duration = 1000;
        $points = array();
        $distance = array();
        $furthest_deer = '';
        $furthest_distance = 0;

        // point system, per second
        while($duration)
        {
            $tie = false;

            foreach ($deer as $d)
            {
                $d = explode(" ", $d);

                if(!isset($points[$d[0]]))// setup, everyone starts flying
                {
                    $points[$d[0]]['score'] = 0;
                    $points[$d[0]]['distance'] = 0;
                    $points[$d[0]]['rest'] = 0;
                    $points[$d[0]]['fly'] = $d[6];
                }

                if($points[$d[0]]['fly'] > 0)// flying
                {
                    $points[$d[0]]['distance'] += $d[3];
                    $points[$d[0]]['fly']--;
                    // if flight is over
                    if($points[$d[0]]['fly'] == 0){ $points[$d[0]]['rest'] = $d[13]; }
                }
                else// resting
                {
                    $points[$d[0]]['rest']--;
                    // if rest is over
                    if($points[$d[0]]['rest'] == 0){ $points[$d[0]]['fly'] = $d[6]; }
                }
            }

            // pick winner(s)
            foreach ($points as $k => $v)
            {
                if($v['distance'] > $furthest_distance)
                {
                    $furthest_distance = $v['distance'];
                    $furthest_deer = $k;
                    $tie = false;
                }
                elseif($v['distance'] == $furthest_distance)
                {
                    $tie = true;
                }
            }

            // award points
            if($tie)
            {
                foreach ($points as $p)// everyone tied gets a +1
                {
                    if($p['distance'] == $furthest_distance){ $p['score']++; }
                }
            }
            else
            {
                $points[$furthest_deer]['score']++;
            }
            //var_dump($points);
            //var_dump($furthest_deer);
            $duration--;
        }

        var_dump($points);