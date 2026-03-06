namespace Domain {
	public class Kat : IDier {

#region properties
		string naam {get;}
#endregion
		public void MakeSound() {
			Console.WriteLine("miauw");
		}

		public Kat(string naam) {
			this.naam = naam;
		}
	}
}
