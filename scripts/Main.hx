import haxe.Timer;
import hxcore.flecs.Flecs;
import hxcore.util.FPSCounter;

class Main extends Script {
	var eid:Int;

	// override function onUpdate(deltaTimeMS:Float) {
	// log('Update: (${Math.round(deltaTimeMS)} ms, ${FPSCounter.FPS()} fps)');
	// }
	// override function onFixedUpdate(frameDurationMS:Float) {
	//	log('FixedUpdate: ($frameDurationMS ms)');
	// }


	function init() {
		Flecs.init();

		var positionId = Flecs.getComponentId("Position");
		var velocityId = Flecs.getComponentId("Velocity");
		var destinationId = Flecs.getComponentId("Destination");

		Flecs.registerObserver([positionId], [Flecs.EcsOnSet], (entity_id:Int, component_id:Int, event_id:Int) -> {
            var pos = Flecs.getPosition(entity_id);
            var vel = Flecs.getVelocity(entity_id);
			var dest = Flecs.getDestination(entity_id);
            Log.info('OnSet: $entity_id, $component_id, $event_id, Position: ${pos}, Velocity: ${vel}, Destination: ${dest}');
        });

		
		eid = Flecs.createEntity("spaceship");
		
		Flecs.setPosition(eid, 0, 0);
		Flecs.addComponent(eid, velocityId);
		//Flecs.setVelocity(eid, 0, 0);
		Flecs.setDestination(eid, 10, 10, 0.1);  // no velocity, destination won't work!
	}

	function fini() {
		Flecs.fini();
	}

	override function onLoad() {
		init();
	}

	override function onReload() {
		init();
	}

	override function onUnload() {
		fini();
	}

	override function onUpdate(deltaTimeMS:Float) {
		Flecs.progress();

		/*
        var pos = Flecs.getEntityPosition(eid);
		if (pos != null) {
			Log.info("Position: " + pos.x + ", " + pos.y);
		}
        */
	}

	override function onFixedUpdate(frameDurationMS:Float) {
		// Flecs.progress();
	}
}
