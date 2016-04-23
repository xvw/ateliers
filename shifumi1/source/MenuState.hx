package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxBasic;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;
import flixel.group.FlxGroup;

class MenuState extends FlxState
{

	private var computer: Int;
	private var group: FlxTypedGroup<FlxBasic>;

	private function drawText(t:String, y:Int, c:FlxColor, o:FlxColor, s:Int): Void {
		var title = new FlxText();
  	title.text = t;
  	title.color = c;
  	title.size = s;
  	title.alignment = FlxTextAlign.CENTER;
  	title.setBorderStyle(FlxTextBorderStyle.SHADOW, o, 4);
  	title.screenCenter();
		title.y -= y;
  	group.add(title);
	}

	private function drawTitle(): Void {
		drawText("Your weapon?", 54, FlxColor.YELLOW, FlxColor.RED, 32);
	}

	private function drawButtons(): Void {
		var rock  = new FlxButton(0, 0, "Rock", pressRock);
		var paper = new FlxButton(0, 0, "Paper", pressPaper);
		var sciss = new FlxButton(0, 0, "Scissors", pressScissors);
    rock.screenCenter();
		paper.screenCenter();
		sciss.screenCenter();
		paper.y += 22;
		sciss.y += 44;
    group.add(rock);
		group.add(paper);
		group.add(sciss);
	}

	private function pressRock(): Void {
		checkVictory(0);
	}

	private function pressPaper(): Void {
		checkVictory(1);
	}

	private function pressScissors(): Void {
		checkVictory(2);
	}

	private function choice(V:Int): String {
		if (V == 0) { return "Rock"; }
		if (V == 1) { return "Paper";}
		return "Scissors";
 	}

	private function getMessage(result:Int): String {
		if (result == 0) { return "Draw!"; }
		if (result == 1) { return "You Win !!!"; }
		return "You looooose :'( !!!";
	}

	private function finalScene(V: Int, result:Int) : Void {
		group.clear();
		var a = choice(V);
		var b = choice(computer);
  	drawText('YOU : $a, COMPUTER: $b', 54, FlxColor.YELLOW, FlxColor.RED, 18);
		drawText(getMessage(result), 20, FlxColor.RED, FlxColor.YELLOW, 34);
		var prev  = new FlxButton(0, 0, "Replay !", replay);
		prev.screenCenter();
		prev.y += 12;
		group.add(prev);
	}

	private function replay() {
		FlxG.switchState(new MenuState());
	}

	private function checkVictory(V:Int) : Void {
		computer = Std.random(3);
		var result = 0;
		trace("YOU:", V, "Computer:", computer);
		if ((V - computer + 3) % 3 == 1) {
			result =  1;
		} else {
			if (V != computer) {
				result = 2;
			}
		}
		finalScene(V, result);
	}

	override public function create(): Void
	{
		super.create();
		group = new FlxTypedGroup<FlxBasic>(10);
		drawTitle();
		drawButtons();
		add(group);
	}
}
