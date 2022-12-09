/// @description Animation

// Rotate Cloud
image_angle += rotSpeed;
y -= driftSpeed;

// fade out
if (image_alpha > 0) {
	image_alpha -= fadeSpeed;	
}
if (image_alpha <= 0) {
	instance_destroy();	
}