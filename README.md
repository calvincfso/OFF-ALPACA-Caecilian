# OFF-ALPACA-Caecilian
BISC6232 Hackathon ALPACA application on scans of caecilian skulls

# Background information
Intraspecific trait variation is the wellspring from which heritable raw material for evolution emerges. In light of this, it is key to exploring questions in ecology and evolution. Biologists over the years have documented differences in the individuals of the same species for conspicuous traits such size, gender, shape, and physiology, and have since explored intraspecific variation for the covariation of these features to investigate evolutionary processes such as selection. Shape variation is a frequent variable used to study its covariation with other features and its relationship with selection. Here, we investigate the intraspecific trait variation in the skull of caecilian Boulengerula boulengeri and assess the degree of sexual dimorphism in the species, exploring its covariation with skull shpae. We utilize and compare two landmarking methods of quantifying shape variation and their accuracies.

The most frequently employed method of quantifying shape variation is the use of landmarks, points used to represent shape, in geometric morphometrics, a class of analyses that explore shape variation. Historically, biologists applied landmarks onto two- and three-dimensional images or models manually. Porto et al. (2021) offer Automated Landmarking through Point cloud Alignment and Correspondence Analysis (or ALPACA, for short) in 3D Slicer, which uses a reference specimen to demarcate template landmarks from which landmarks will be applied to conspecifics.

# Purpose of the project
* Investigate the accuracy of manual versus semi-automated landmarks (ALPACA)
* Assess the degree of sexual dimorphism in caecilian skulls

# Contact information

* Calvin So (calvinso@gwu.edu)

* Jake Galvin (jtglvn@gmail.com)

* Jonathan Huie (jonathanmhuie@gmail.com)


# Other resources

**Software**

* 3D Slicer - https://www.slicer.org/
* SlicerMorph - https://github.com/SlicerMorph/SlicerMorph

* R Studio - https://www.rstudio.com/

**Other Tutorials**

* Installing SlicerMorph - https://github.com/SlicerMorph/SlicerMorph

* ALPACA Module - https://github.com/SlicerMorph/Tutorials/tree/main/ALPACA

* GPA Module - https://github.com/SlicerMorph/Tutorials/tree/main/GPA_1

**References**

* Porto, A., Rolfe, S., & Maga, A. M. (2021). ALPACA: A fast and accurate computer vision approach for automated landmarking of three‐dimensional biological structures. Methods in Ecology and Evolution, 12(11), 2129-2144.

* Marshall, A. F., Bardua, C., Gower, D. J., Wilkinson, M., Sherratt, E., & Goswami, A. (2019). High-density three-dimensional morphometric analyses support conserved static (intraspecific) modularity in caecilian (Amphibia: Gymnophiona) crania. Biological Journal of the Linnean Society, 126(4), 721-742.

# Tutorial

**Getting started**

For this tutorial, we will be using the open-source bio-imaging platform 3D Slicer and the SlicerMorph extension. Follow the instructions here to download and install the software. You will also need to download and install R Studio.

To begin, obtain scans from your preferred source. In this tutorial we will be using https://www.phenome10k.org to obtain CT scans of the neurocranium of _Boulengerula boulengeri_, originally from Marshal et al. (2019). In this demo, we obtained a small sample size of fifteen different models (.stl), with seven scans of male caecilians, seven scans of female caecilians, and one skull of unknown sex. You will need to create an account on phenome10k to access its database.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126231-085797de-340f-4388-9ba4-b5dedf5e984c.png">


**Manual landmarking in 3D Slicer**

Load one of the downloaded models into 3D Slicer by dragging and dropping it into your workspace or by using the “Add Data” function. The model should be added as a .stl file (e.g. example.stl). Set your view to 3D only for better viewing of the model. You should have one workspace window open in slicer with a view of an .stl mesh similar to this:

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126239-e172102b-9b50-4655-ad7a-e7713c3e3aa4.png">


Navigate to the Markups module in 3D Slicer and create a new fiducial markup. Place your first point on the imported mesh on the tip of the snout. 

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126246-58338d41-85f0-41c5-ac4a-0c70f3c73368.png">


Using the “create and place” button in the toolbar (red dot with blue arrow), add additional landmark points to the mesh as part of the same fiducial markup node. You may follow the landmarking scheme depicted in the subsequent images or use your own. When adding a new landmark, make sure to add to the existing fiducial mark up node and not create another. Note: For geometric morphometrics, it is important to be consistent and place landmarks in the same across skulls. Landmarks placed out of order will need to improper results

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126254-c66e58cd-c28c-4003-a2fd-0a1b256f03b5.png">
<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126326-ed09a9f2-4ee8-4069-bb52-cbd2cbbaf120.png">
<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126337-ac497960-c7a9-4c0f-85d4-c822a1445115.png">


After you finish adding your points, save and export the landmarks as a fiducial csv (.fcsv), and save the mesh you were working on as a .ply file. Clear the current scene and repeat the landmarking process for all of the desired specimens. We will use the saved .ply files to generate automated landmarks using ALPACA and compare them to the landmarks applied manually.

**Automated landmarking using ALPACA**

To use ALPACA and automate the landmarking process, we will be following this tutorial but will provide brief instructions below. 

Navigate to the ALPACA module in 3D Slicer. Under “Source mesh” and “Source landmarks”, select one of the caecilian .ply files and corresponding .fcsv with its landmarks. The source mesh and landmarks will be used as a template to transfer the landmarks on the “Target mesh” of your choosing. Now, click “Run subsampling”. In the 3D view, you should now see a point cloud that resembles the source mesh. The progress window should indicate that the source and target point clouds have ~7000 points each, per Porto et al. (2021). If not, under “Advanced parameter settings” adjust the Point Density and re-run the subsampling until they do.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126436-fe54688f-4972-4304-ac9a-f16fac815e48.png">

Once the source and target point clouds have the appropriate number of points, click through the remaining buttons in order. The rigid alignment will first try to scale and rotate the target mesh to match the source.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126442-7e4ee05c-1af7-40da-a3f0-d57941f5d33e.png">


The CPD non-rigid registration will warp and deform the target mesh to best match the source. This way the source landmarks can be transferred to a target mesh that more closely resembles the source. Don’t worry, ALPACA then transforms the deformed mesh and its newly transferred landmarks back into the original target model with refined landmarks. This step may take a few minutes. After running the non-rigid registration, you should see the target mesh with landmarks that closely resemble the original source mesh. If the points are very off, you may need to refine more of the advanced parameters but for the purpose of this demo we will move on.

<img width="468" alt="image" align = "center" src="https://user-images.githubusercontent.com/52302862/145126452-ea112a67-fada-4971-a4ea-85d01d4abfdd.png">


Now that we’ve tested ALPACA out on a single target mesh, it’s time to apply to a whole batch. Under the “Batch processing” tab in the ALPACA module, select your source mesh and its landmarks (same as before), but this time instead of choosing a single target mesh select a folder that contains all of the meshes you want to transfer landmarks to. Also select a folder where all of the landmark files (.fscv) should be saved. Confirm the Advanced parameter settings and start the auto-landmarking. Wait a few minutes and tada! That’s how you run ALPACA on a series of meshes.

**Generalized procrustes analysis in 3D Slicer**

Now that you have both your manual and automated landmark files, it’s time to run a generalized procrustes analysis. This analysis can be done in R using the “geomorph” package or the GPA module in 3D Slicer. We will use the GPA module so navigate to it. Click “Select Landmark Files” and select .fcsv files for both the manual and automated landmarks (it’s best to have them all in one folder. Then select a folder to save the results of the analysis and click Execute.

The results of the generalized procrustes analysis and a principal component analysis can be visualized using the GPA module as outlined here, but they can also be imported in R to be analyzed further. We will use the latter.

**Visualizing data in R**

In this repository, we have provided example GPA module outputs and an R script that can be used to import and visualize the data. The script has three primary goals, 1) plot a principal component analysis plot that shows the shape variation between the manual and automated landmarks and 2) plot a regression with manual and automated shapes to assess their correlation. Additional information about the analyses are included as annotations in the R script file.

The results of the PCA plot show that there is some overlap in shape variation between the manual and automated landmarks. Some points corresponding to the same individual were close together, while others were far apart. One set of automated landmarks was clearly distinct from the rest of the manual and automated landmarks. There is also some evidence of sexual dimorphism in the caecilian skulls.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126465-e12f1fe8-aa05-4634-8b87-b9ad58b371f8.png">


When plotting PC 1 scores for the manual and automated landmarks against each other, there initially appeared to be no correlation. However, the extreme outlier may confound these results. After removing the outlier, there is a weak correlation between the manual and automated landmarks, indicating moderate accuracy between the two methods.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126475-a8696680-4f48-4566-bd39-0de170c2ff21.png">


# Conclusions
