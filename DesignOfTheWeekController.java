package com.ui.controller;

import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.TimeZone;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ui.dao.DesignOfTheWeekDAO;
import com.ui.dao.ProductDAO;
import com.ui.model.DesignImage;
import com.ui.model.DesignOfTheWeek;
import com.ui.model.DesignWeekCollection;
import com.ui.model.Discount;
import com.ui.model.ProductImage;
import com.ui.model.ProductStory;

@RestController
public class DesignOfTheWeekController {

  @Autowired
  DesignOfTheWeekDAO designOfTheWeekDAO;
  
  DesignOfTheWeek designOfTheWeek;
  
  DesignWeekCollection designWeekCollection;
  
  DesignImage designImage;
  
  ProductDAO productDAO;
  
  private static final Logger logger = LoggerFactory.getLogger(DesignOfTheWeekController.class);
  
  @RequestMapping(value="addDesignWeek", method= RequestMethod.POST)
  public int addDesignWeek(String fromDate, String toDate, HttpServletRequest request, HttpSession session) {
      logger.info("***** ADD DESIGN OF THE WEEK CONTROLLER *****");     
      int id = Integer.parseInt(session.getAttribute("adminid").toString());      
      String ip_address = request.getHeader("X-FORWARDED-FOR");
      if (ip_address == null) {
        ip_address = request.getRemoteAddr();
      }
      String s ="y";     
      
     // designOfTheWeek = new DesignOfTheWeek(fromdate, todate,  productid, ip_address);
      
      int designOfTheWeekId;
      designOfTheWeek = new DesignOfTheWeek();
      designOfTheWeek.setFromDate(fromDate);
      designOfTheWeek.setToDate(toDate);
      designOfTheWeek.setIp_address(ip_address);
      designOfTheWeek.setCreated_by(id);
      designOfTheWeek.setStatus(s);
      
      designOfTheWeekId = designOfTheWeekDAO.addDesignWeek(designOfTheWeek);
      // designOfTheWeekDAO.getLastDesignOfTheWeekId();
      return designOfTheWeekId;
  }
  
  @RequestMapping(value="addDesignWeekCollection", method= RequestMethod.POST)
  public void addDesignWeekCollection(int designOfTheWeekId, int product_id, HttpServletRequest request, HttpSession session) {
      logger.info("***** ADD DESIGN WEEK COLLECTION CONTROLLER *****");     
      int id = Integer.parseInt(session.getAttribute("adminid").toString());      
      String ip_address = request.getHeader("X-FORWARDED-FOR");
      if (ip_address == null) {
        ip_address = request.getRemoteAddr();
      }
      String s ="y";     
      
     // designOfTheWeek = new DesignOfTheWeek(fromdate, todate,  productid, ip_address);
      
      designWeekCollection = new DesignWeekCollection();
      designWeekCollection.setDesign_of_the_week_id(designOfTheWeekId);
      designWeekCollection.setProduct_id(product_id);
      designWeekCollection.setIp_address(ip_address);
      designWeekCollection.setCreated_by(id);
      designWeekCollection.setStatus(s);
      
      designOfTheWeekDAO.addDesignWeekCollection(designWeekCollection);
      // designOfTheWeekDAO.getLastDesignOfTheWeekId();
  }
  
  @RequestMapping(value="/getDesignWeeksByPage", method= RequestMethod.GET, produces = "application/json")
  public List<DesignOfTheWeek> getDesignWeeksByPage(int pagesize, int startindex, HttpServletRequest request) {
      logger.info("***** DESIGN OF THE WEEK BY PAGE *****");       
      List<DesignOfTheWeek> designOfTheWeeks = designOfTheWeekDAO.getDesignWeeksByPage(pagesize, startindex);     
      return designOfTheWeeks;
  }
  
  @RequestMapping(value="/getDesignWeeksCollectionById", method= RequestMethod.GET, produces = "application/json")
  public List<DesignWeekCollection> getDesignWeeksCollectionById(int DesignWeekid, HttpServletRequest request) {
      logger.info("***** DESIGN OF THE WEEK BY ID *****");       
      List<DesignWeekCollection> designWeekCollections = designOfTheWeekDAO.getDesignWeeksCollectionById(DesignWeekid);     
      return designWeekCollections;
  }
  
  @RequestMapping(value="/getDesignWeek", method= RequestMethod.GET, produces = "application/json")
  public List<DesignOfTheWeek> getDesignWeek(HttpServletRequest request) {
      logger.info("***** GET DESIGN OF THE WEEK *****");       
      List<DesignOfTheWeek> designOfTheWeek = designOfTheWeekDAO.getDesignWeeks();       
      return designOfTheWeek;
  }
  
  @RequestMapping(value="editDesignWeek", method= RequestMethod.POST)
  public String editDesignWeek(int DesignWeekid, String fromdate, String todate, HttpServletRequest request, HttpSession session) {
      logger.info("***** EDIT DESIGN OF THE WEEK *****");
      int id = Integer.parseInt(session.getAttribute("adminid").toString());
      String IpAddress = request.getHeader("X-FORWARDED-FOR");
      if (IpAddress == null) {
          IpAddress = request.getRemoteAddr();
      }
      String s="y";
      designOfTheWeek =new DesignOfTheWeek();
      
      System.out.println("============ from date="+fromdate+" "+todate);
      
      designOfTheWeek.setFromDate(fromdate);
      designOfTheWeek.setToDate(todate);
      designOfTheWeek.setIp_address(IpAddress);
      designOfTheWeek.setCreated_by(id);
      designOfTheWeek.setStatus(s);
      designOfTheWeek.setDesignWeekID(DesignWeekid);
      designOfTheWeekDAO.editDesignWeek(designOfTheWeek);
      return "";
  }
  
  @RequestMapping(value="/getDesignWeekById", method= RequestMethod.GET, produces = "application/json")
  public DesignOfTheWeek getDesignWeekById(int id,HttpServletRequest request) {
      logger.info("***** GET DESIGN OF THE WEEK BY ID *****");       
      DesignOfTheWeek designOfTheWeek = designOfTheWeekDAO.getDesignWeekById(id);       
      return designOfTheWeek;
  }
  
  @RequestMapping(value="deleteDesignWeek", method= RequestMethod.DELETE)
  public void delete(int DesignWeekid) {
      logger.info("***** DELETE DESIGN OF THE WEEK *****");
      designOfTheWeekDAO.deleteDesignWeek(DesignWeekid);
  }
  
  @RequestMapping(value="editDeleteDesignList", method= RequestMethod.DELETE)
  public void editDeleteDesignList(int DesignWeekid) {
      logger.info("***** DELETE DESIGN OF THE WEEK *****");
      designOfTheWeekDAO.editDeleteDesignList(DesignWeekid);
  }
  
  @RequestMapping(value="/getDesignOfTheWeek", method= RequestMethod.GET, produces = "application/json")
  public List<DesignOfTheWeek> getDesignOfTheWeek(HttpServletRequest request, HttpSession session) 
  {
      logger.info("***** GET DESIGN OF THE WEEK CONTROLLER *****");
      
      Date date = new Date();
      SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
      SimpleDateFormat dayformat = new SimpleDateFormat("EEEEE");
      format1.setTimeZone(TimeZone.getTimeZone("IST"));
      String todaydate = format1.format(date);
      
      List<DesignOfTheWeek> designOfTheWeek = designOfTheWeekDAO.getDesignOfTheWeek(todaydate);
      
      return designOfTheWeek;
  }
  //--------------------------------

  @RequestMapping(value = "addDesignImage", method = RequestMethod.POST)
  public String addProductImage(@RequestParam(value = "productImage", required = false)  MultipartFile[] productImage, String imagetitle[], String imagedescription[],String imagesequence[],int valuex[], int valuey[], int valuew[], int valueh[], int productId[],int designOfTheWeekId, HttpServletRequest request, HttpSession session) {
    logger.info("***** INSIDE ADD Design IMAGE *****");
    int id =0;   
    
    String IpAddress = request.getHeader("X-FORWARDED-FOR");
    if (IpAddress == null) {
      IpAddress = request.getRemoteAddr();
    }
    
    String status="y";
    
   // int productid = productdao.getLastProductId();
 

    String image = null;
    try {
      for (int i = 0; i < imagetitle.length; i++) {
    	  String apRandStr = randString();
    	  System.out.println("x---------"+valuex[i]);
    	  System.out.println("y------------"+valuey[i]);
    	  System.out.println("w----------"+valuew[i]);
    	  System.out.println("h--------"+valuey[i]);
    	  
        if (productImage[i].getOriginalFilename() != null && productImage[i].getOriginalFilename() != "") {
          try {
            byte[] bytes = productImage[i].getBytes();

            File dir = new File(request.getRealPath("") + "/resources/admin/images" + File.separator + "DesignImages");
            if (!dir.exists())
              dir.mkdirs();
            String path = request.getRealPath("/resources/admin/images/DesignImages/");
            File uploadfile = new File(path + File.separator +apRandStr+ productImage[i].getOriginalFilename());
            int height = 825, width = 825;
            ByteArrayInputStream in = new ByteArrayInputStream(bytes);
            try {
              BufferedImage img = ImageIO.read(in);

              Image scaledImage = img.getScaledInstance(valuew[i], valueh[i], Image.SCALE_SMOOTH);
              BufferedImage SubImgage = img.getSubimage(valuex[i], valuey[i], valuew[i], valueh[i]);
              Graphics2D drawer = SubImgage.createGraphics();
              drawer.setComposite(AlphaComposite.Src);
              drawer.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
              drawer.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
              drawer.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
              drawer.drawImage(scaledImage, valuew[i], valueh[i], null);
              drawer.dispose();
              ByteArrayOutputStream buffer = new ByteArrayOutputStream();
              ImageIO.write(SubImgage, "jpg", buffer);
              bytes = buffer.toByteArray();



              /*
               * Image scaledImage = img.getScaledInstance(width, height, Image.SCALE_FAST);
               * BufferedImage imageBuff = new BufferedImage(width, height,
               * BufferedImage.TYPE_INT_RGB); Graphics2D drawer = imageBuff.createGraphics();
               * drawer.drawImage(scaledImage, 0, 0, null); drawer.dispose();
               * 
               * ByteArrayOutputStream buffer = new ByteArrayOutputStream();
               * ImageIO.write(imageBuff, "jpg", buffer); bytes = buffer.toByteArray();
               */
            } catch (IOException e) {
              // throw new ApplicationException("IOException in scale");
            }

            System.out.println("*********************Path" + path);

            BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(new FileOutputStream(uploadfile));
            bufferedOutputStream.write(bytes);
            bufferedOutputStream.close();
            File f = new File(path);
            File files[] = f.listFiles();

            /*
             * for (int j = 0; j < files.length; j++) { if (files[j].isFile()) {
             * System.out.println("File " + files[j].getName() + " " + files[j].length()); } }
             */

            //image = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/omessa/resources/admin/images/DesignImages/" +apRandStr+ productImage[i].getOriginalFilename();
            image = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+"/resources/admin/images/DesignImages/"+apRandStr+productImage[i].getOriginalFilename();
            System.out.println("image-----------" + image);
            String d = "";
            
            if(imagedescription[i].toString().equalsIgnoreCase("ooo"))
            	d = "";
            else
            	d = imagedescription[i].toString();

          //  designImage = new ProductImage(imagesequence[i].toString(), imagetitle[i].toString(), d, image, productid, id, IpAddress);
           
            System.out.println("imageTitle=====================+++++++"+imagetitle[i]);
            designImage = new DesignImage();
            designImage.setP_title(imagetitle[i]);
            designImage.setP_disc(d);
            designImage.setSequence_i(imagesequence[i].toString());
            designImage.setFile(image);
            designImage.setCreated_by(id);  
            designImage.setProduct_id(productId[i]);
            designImage.setDesign_of_the_week_id(designOfTheWeekId);
            designImage.setIp_address(IpAddress);
            designImage.setStatus(status);
            
            
            designOfTheWeekDAO.addDesignImage(designImage);
           
            
          } catch (Exception e) {
            e.printStackTrace();
          }
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return "";
  }

  public String randString() {
	  int leftLimit = 97; // letter 'a'
	    int rightLimit = 122; // letter 'z'
	    int targetStringLength = 10;
	    Random random = new Random();
	    StringBuilder buffer = new StringBuilder(targetStringLength);
	    for (int i = 0; i < targetStringLength; i++) {
	        int randomLimitedInt = leftLimit + (int) 
	          (random.nextFloat() * (rightLimit - leftLimit + 1));
	        buffer.append((char) randomLimitedInt);
	    }
	    String generatedString = buffer.toString();

	    return generatedString;
	}
//---------------------
  @RequestMapping(value="/getDesigImageById", method= RequestMethod.GET, produces = "application/json")
  public List<DesignImage> getDesignImageById(int designOfTheWeekId,HttpServletRequest request) {
      logger.info("***** GET DESIGN Image BY ID *****");       
     List<DesignImage> di= designOfTheWeekDAO.getDesignImageById(designOfTheWeekId);       
      return di;
  }
  
  @RequestMapping(value = "deleteDesignImage", method = RequestMethod.DELETE)
  public void deleteImage(int designImageId) {
    logger.info("***** INSIDE DELETE DESIGN IMAGE CONTROLLER *****");
  System.out.println("ddddddddddddddddddddddddddddddddddddddddddddddd"+designImageId);
    designOfTheWeekDAO.deleteDesignImage(designImageId);
   
  }

	/*
	 * @RequestMapping(value = "/getAllDesignImages", method = RequestMethod.GET,
	 * produces = "application/json") public List<DesignImage>
	 * getdesignimage(HttpServletRequest request) {
	 * logger.info("***** INSIDE PRODUCT CONTROLLER *****"); List<DesignImage>
	 * listdesign =designOfTheWeekDAO.getllDesignImages(); return listdesign; }
	 */
  
  
}
