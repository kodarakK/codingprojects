using Domain;
using System.Collections.Generic;

#region Dier interface example
var kat = new Kat("kobbe");
kat.MakeSound();
#endregion

IEnumerable<string> list = new List<string> {
	"number one",
	"number two",	
	"number three"
};

foreach (string s in list) {
	Console.WriteLine(s);
}


var list2 = new List<int > { 1, 2, 3, 4 };
foreach (var item in list2)
	Console.WriteLine(item);


var evenList2 = list2.Where(item => item % 2 == 0);
foreach (var item in evenList2) 
	Console.WriteLine(item);
