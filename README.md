# Pinhole-Camera-Model-

This project is a simple implementation of the pinhole camera model in Matlab 2020b with the purpose of studying the single camera geometry, in particular the projection from Euclidean space in 3D to the image space in 2D. It is possible to execute the experiment both in a Matlab script and in Simulink.

The file are organized as follows:

- **sistemi_di_riferimento.m** : script that creates the reference systems *world frame* and *camera frame*;
- **camera.m** : It is the main matlab sript. It simulates the projection in the image plane of a point and a rectangle, located in front of the camera at a fixed distance and creates the relative plots;
- **proj.m** : function that executes the projection in the image plane;
- **rot.m** : function that executes the rototraslation from world frame to camera frame;
- **take_photo** : function that returns the projection in another 2D plot (like a photograph);
- **init.m** : file in which the variable for the Simulink simulation are initialized;
- **camera_model.slx** : simulink model of the pinhole camera, which was also saved in Matlab 2019b (camera_model_2019b.slx);
- **plot_simulink.m** : script that shows the results of the Simulink simulation.


<h3>Matlab script</h3>
To execute the Matlab script is enough to run camera.m. Parameters that can be changed are:

- **O**, which is the position of the world frame;
- **C**, which is the position of the camera frame;
- **f**, focal distance of the camera, which is a fundamental parameter of the camera.

After the execution of the script two plots will appear: one for the projection of a generic point and one for the projection in the image plane of an inclined rectangle, as mentioned above.

The second plot also contains the projection in a separate chart (as a photograph).

<figure class="image">
  <img src="pictures/point_projection.png" width="760">
  <figcaption></figcaption>
</figure>

<figure class="image">
  
  
  <img src="pictures/rectangle_projection.png" width="760">
  <figcaption></figcaption>
</figure>



<h3>IBVS</h3>



<h3>PBVS</h3>
