### OpenCV 사용하기

OpenCV 설치 방법 등은 [OpenCV](../_draft/2016-10-12-OpenCV.md) 글을 참고하시기 바랍니다. (나중에 포스트로 옮기면 링크를 수정해야 합니다.)

[Structure From Motion](http://docs.opencv.org/3.1.0/de/d7c/tutorial_table_of_content_sfm.html) : tutorial table

[Structure From Motion](http://docs.opencv.org/3.1.0/d8/d8c/group__sfm.html) : group

#### Dependencies

SfM을 OpenCV에서 사용하기 위해서는 아래의 다른 라이브러리도 같이 필요합니다. 

[Eigen](http://eigen.tuxfamily.org/index.php?title=Main_Page)

[GLog](https://github.com/google/glog)

[GFlags](https://github.com/gflags/gflags) : [How To Use gflags (formerly Google Commandline Flags)](https://gflags.github.io/gflags/)

[Ceres Solver](http://ceres-solver.org)

### Structure from Motion

[Lecture 6: Multi-view Stereo & Structure from Motion](http://cs.nyu.edu/~fergus/teaching/vision/11_12_multiview.pdf) : Rob Fergus 교수님의 강의 자료입니다.

[VisualSFM : A Visual Structure from Motion System](http://ccwu.me/vsfm/)

[Chapter 13 Structure from motion](http://mi.eng.cam.ac.uk/~cipolla/publications/contributionToEditedBook/2008-SFM-chapters.pdf) : 최소 2008년 자료입니다. 그 시절부터 이미 내용은 완성 단계임을 알 수 있습니다.

#### Libmv

[Libmv](https://developer.blender.org/project/profile/59/) : the Library for Multiview Reconstruction

#### Structure From Motion Pipeline

[Structure From Motion Pipeline](https://github.com/NLeSC/structure-from-motion)

### Papers

[Structure from Motion with Objects](http://www.cv-foundation.org/openaccess/content_cvpr_2016/papers/Crocco_Structure_From_Motion_CVPR_2016_paper.pdf)

[Segmentation and Recognition using Structure from Motion Point Clouds](http://www.cs.ucl.ac.uk/fileadmin/UCL-CS/images/CGVI/Gabriel1.pdf)

[Semantic Structure From Motion with Object and Point Interactions](http://vhosts.eecs.umich.edu/vision//papers/bao_CORP2011.pdf)

[Unsupervised 3D Object Recognition and Reconstruction in Unordered Datasets](https://www.cs.ubc.ca/labs/lci/papers/docs2005/brown05.pdf) : 논문이 얼마나 의미있는지는 아직 모르겠으나 많이 인용되었습니다.

[Dynamic SfM: Detecting Scene Changes from Image Pairs](http://geometry.cs.ucl.ac.uk/projects/2015/dynamicSfM/paper_docs/dynamicSfm.pdf)

### Datasets

[vision.middlebury.edu](http://vision.middlebury.edu/mview/data/) : Temple 과 Dino 대상에 대한 데이터셋을 제공하고 있습니다. 

### OpenCV 

아래 자료들은 OpenCV 쪽으로 옮겨야할 것 같습니다.

[OpenCV  3.1.0 Docs](http://docs.opencv.org/3.1.0/d1/dfb/intro.html)

[Scene Reconstruction](http://docs.opencv.org/3.1.0/d4/d18/tutorial_sfm_scene_reconstruction.html)

[opencv/opencv_contrib](https://github.com/opencv/opencv_contrib/tree/master/modules/sfm) : opencv_contrib/modules/sfm/

#### Ceres Solver

[Ceres Solver](http://ceres-solver.org)
