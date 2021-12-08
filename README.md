# Manual vs. Automated Landmarks
BISC6232 Hackathon ALPACA application on scans of caecilian skulls by Calvin So (calvinso@gwu.edu), Jake Galvin (jtglvn@gmail.com), and Jonathan Huie (jonathanmhuie@gmail.com).

# Background information
Intraspecific trait variation is the wellspring from which heritable raw material for evolution emerges. In light of this, it is key to exploring questions in ecology and evolution. Biologists over the years have documented differences in size, shape, physiology, and more between individuals of the same species. These traits may vary between sexes or the different life stages of a species. Of traits often analyzed and compared, shape has always been popular due to its heritability and its link (both direct and indirect) to an organism’s performance and fitness. 

A common method of quantifying shape variation is geometric morphometrics, which employs the use of landmarks or points to represent shape. Historically, biologists have manually applied their landmarks 2D images, and more recently 3D models. However, as the resolution of our analyses and the sample size of our data sets increase, so do the number of landmarks needed. Thus, there is a real need for an efficient and accurate method of applying landmarks. Porto et al. (2021) offers a solution through Automated Landmarking through Point Cloud Alignment and Correspondence Analysis (ALPACA), a custom module for the open-source and bio-imaging platform 3D Slicer. ALPACA combines both rigid and deformable image registration to transfer a series of landmarks from a template model onto a batch of target models. This software presumably works best when used to capture intraspecific, rather than interspecific, variation.

Here, we outline the steps needed to analyze intraspecific shape variation in the skull of the caecilian, Boulengerula boulengeri, and assess the degree of sexual dimorphism in the species. We use both manual and automated landmarking methods, and compare the accuracy of the automated landmarks relative to the manual ones.

# Table of Contents
* Automated Landmarks - .fcsv landmark files generated through ALPACA
* Manual Landmarks - .fcsv landmark files generated through ALPACA
* PLY - .ply caecilian skull models used in this demo
* Raw GPA Outputs - files exported by the GPA module after running the generalized procrustes analysis and principal component analysis
* OFF_ALPACA_Caecilian_Script.R - R script used to analyze and visualize the data in the demo
* pcScores.csv - speadsheet with the individual PCA scores, sex classifications, and more. 

# Resources

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

For this tutorial, we will be using 3D Slicer and the SlicerMorph extension. Follow the instructions on the SlicerMorph website on how to download and install the software. You will also need to download and install R Studio to analyze the data later on. The _Boulengerula boulengeri_ skull models analyzed in this tutorial are included can be downloaded from this repo but were originally downloaded from https://www.phenome10k.org. The data itself was initially published in to originally from Marshal et al. (2019). For this demo, we obtained a small sample size of fifteen different models (.stl), with seven scans of male caecilians, seven scans of female caecilians, and one skull of unknown sex. You will need to create an account on phenome10k to access its database.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126231-085797de-340f-4388-9ba4-b5dedf5e984c.png">


**Manual landmarking in 3D Slicer**

Load one of the downloaded models into 3D Slicer by dragging and dropping it into your workspace or by using the “Add Data” function. The model should be loaded in as a .stl file. It is recommended to hange your Slicer window show the 3D only for easier viewing of the model. You should now see your loaded model in the 3D view on the right, similar to this:

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126239-e172102b-9b50-4655-ad7a-e7713c3e3aa4.png">


Navigate to the Markups module in 3D Slicer and create a new fiducial markup. Place your first point on the imported mesh by clickin on the tip of the snout. 

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126246-58338d41-85f0-41c5-ac4a-0c70f3c73368.png">


Using the “create and place” button in the toolbar (red dot with blue arrow), add additional landmark points to the mesh as part of the same fiducial markup node. You may want to follow the landmarking scheme depicted in the subsequent images or use your own. When adding a new landmark, make sure to add to the existing fiducial mark up node and not create another. Note: For geometric morphometrics, it is important to be consistent and place landmarks in the same across skulls. Landmarks placed out of order will lead to improper results.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126254-c66e58cd-c28c-4003-a2fd-0a1b256f03b5.png">
<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126326-ed09a9f2-4ee8-4069-bb52-cbd2cbbaf120.png">
<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126337-ac497960-c7a9-4c0f-85d4-c822a1445115.png">


After you finish adding your points, save and export the landmarks as a fiducial csv (.fcsv), and save the mesh you were working on as a .ply file (instead of a .stl). We will use the saved .ply files to generate automated landmarks using ALPACA. Clear the current scene and repeat the landmarking process for all of the desired models. 

**Automated landmarking using ALPACA**

Navigate to the ALPACA module in 3D Slicer. Under “Source mesh” and “Source landmarks”, select one of the caecilian .ply files and corresponding .fcsv with its landmarks. The source mesh and landmarks will be used as a template to transfer the landmarks on the “Target mesh” of your choosing. Now, click “Run subsampling”. In the 3D view, you should now see a point cloud that resembles the source mesh. The progress window should indicate that the source and target point clouds have ~7000 points each, per Porto et al. (2021). If not, under “Advanced parameter settings” adjust the Point Density and re-run the subsampling until they do.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126436-fe54688f-4972-4304-ac9a-f16fac815e48.png">

Once the source and target point clouds have the appropriate number of points, click through the remaining buttons in order. The rigid alignment will first try to scale and rotate the target mesh to match the source.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126442-7e4ee05c-1af7-40da-a3f0-d57941f5d33e.png">


The CPD non-rigid registration will warp and deform the target mesh to best match the source. This way the source landmarks can be transferred to a mesh that more closely resembles the source. ALPACA then back transforms the deformed mesh and its newly transferred landmarks into the original target model with newly refined landmarks. This step may take a few minutes. After running the non-rigid registration, you should see the target mesh with landmarks that closely resemble the original source mesh. If the points are very off, you may need to refine more of the advanced parameters but for the purpose of this demo we will move on.

<img width="468" alt="image" align = "center" src="https://user-images.githubusercontent.com/52302862/145126452-ea112a67-fada-4971-a4ea-85d01d4abfdd.png">


Now that we’ve tested ALPACA out on a single target mesh, it’s time to apply to the whole batch. Under the “Batch processing” tab in the ALPACA module, select your source mesh and its landmarks (same as before), but this time instead of choosing a single target mesh select a folder that contains all of the meshes you want to transfer landmarks to. Also select a folder where all of the landmark files (.fscv) should be saved. Confirm the Advanced parameter settings and start the auto-landmarking. Wait a few minutes and tada! That’s how you run ALPACA on a series of meshes.

**Generalized procrustes analysis in 3D Slicer**

Now that you have both your manual and automated landmark files, it’s time to run a generalized procrustes analysis. This analysis can be done in R using the “geomorph” package or the GPA module in 3D Slicer. We will use the GPA module so navigate to it. Click “Select Landmark Files” and select .fcsv files for both the manual and automated landmarks (it’s best to have them all in one folder). Then select a folder to save the results of the analysis and click Execute.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145131569-66bf68eb-68f1-4b6e-9bba-fc1c25e9c00d.png">

The results of the generalized procrustes analysis and a principal component analysis (PCA) can be visualized using the GPA module, but they can also be imported in R to be analyzed further. We will use the latter.

**Visualizing data in R**

In this repository, we have provided example GPA module outputs and an R script that can be used to import and visualize the data. The script has three primary goals, 1) plot a PCA plot showing the shape variation associated with sexual dimorphism (if any), 2) plot a PCA that shows the shape variation between the manual and automated landmarks and 2) plot a regression with manual and automated shapes to assess their correlation. Proceed by loading the provided R script into R studios and working through the lines of code.


Figure 1. The PCA plot showing sexual shape dimorphism in the skull. There appears to be more shape variation in male skulls and most are distinct from the female skulls. The individual with the unknown sex is likely a female due to its tight clustering with the female caecilians. This plot only analyzed the manual landmarks.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145130917-2181918c-0d28-41d2-b6bf-271bfbcfab3c.png">

Figure 2. The PCA plot showing that there is some overlap in the captured shape variation between the manual and automated landmarks. Some points corresponding to the same individual were close together, while others were far apart. One set of automated landmarks was clearly distinct from the rest of the manual and automated landmarks. 

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126465-e12f1fe8-aa05-4634-8b87-b9ad58b371f8.png">

Figure 3. When plotting PC 1 scores for the manual and automated landmarks against each other, there initially appeared to be no correlation. However, the extreme outlier may confound these results (left). After removing the outlier, there is a weak correlation between the manual and automated landmarks (right). This result indicates moderate accuracy between the two landmarking methods.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/52302862/145126475-a8696680-4f48-4566-bd39-0de170c2ff21.png">


# Conclusions

We ultimately find that manual landmarking and automated landmarking with ALPACA produce largely incongruent results under a PCA. Only a few individuals between the two methods appear to plot close to each other, which would indicate that ALPACA generated automatic landmarks that matched the manual landmarks. The ingongruent landmarking of ALPACA could be the result of variation in the skulls that is outside of the bounds that ALPACA is able to account. Although these variations are still intraspecific variation, there appears to be limits on what ALPACA can register. In biological reality, these intraspecific variation may be the result of ontogeny or sexual dimorphism. We observed one individual with a shortened interfrontoparietal, which in turn caused the frontals to suture in the midline where it does not in other individuals.


Sexual dimorphism seems to be weakly observable based on the PCA. Female caecilians seem to form a smaller cluster compared to male caecilians, which have some individuals falling within the female cluster. One caecilian of unknown gender was included, but due to the overlapping nature of male and female caecilians in the PCA plot, we are unable to determine its gender.
