import haxe.Timer;
import hxcore.flecs.Flecs;

class ECSTest {
	static function main() {
		Log.info("Hello World");
		Flecs.init();
		var eid = Flecs.createEntity("spaceship");
		Flecs.setPosition(eid, 0, 0);
		Flecs.setVelocity(eid, 0, 0);
        Flecs.setDestination(eid, 10, 10, 0.01);

		var tickTimer = new Timer(Std.int(1000.0 / 60.0));
		tickTimer.run = function() {
			Flecs.progress();
            var pos = Flecs.getPosition(eid);
            if (pos != null) {
                Log.info("Position: " + pos.x + ", " + pos.y);
            }
		};

		// delay 5 seconds, then shut down
		Timer.delay(function() {
            tickTimer.stop();
			Flecs.destroyEntity(eid);
			Flecs.fini();
            Log.info("Goodbye, Cruel World");
		}, 5000);
	}
}
