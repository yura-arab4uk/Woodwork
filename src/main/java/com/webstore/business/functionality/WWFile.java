package com.webstore.business.functionality;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class WWFile {

	public String saveFile (MultipartFile file,HttpServletRequest request,String fileName) {
		String name = fileName;

		if (!file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();
				ServletContext context = request.getServletContext();
				String rootPath = context.getRealPath("/");
				File dir = new File(rootPath+"resources"+ File.separator +"img");

				if (!dir.exists()) {
					dir.mkdirs();
				}

				File uploadedFile = new File(dir.getAbsolutePath() + File.separator + name);

				BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(uploadedFile));
				stream.write(bytes);
				stream.flush();
				stream.close();
				//DELETE THIS !!!
				File uploadedFile1 = new File("d:\\Java_2015\\Woodwork\\src\\main\\webapp\\resources\\img\\" + name);
				BufferedOutputStream stream1 = new BufferedOutputStream(new FileOutputStream(uploadedFile1));
				stream1.write(bytes);
				stream1.flush();
				stream1.close();
				//:~
				return "You successfully uploaded file=" + name;

			} catch (Exception e) {
				return "You failed to upload " + name + " => " + e.getMessage();
			}
		} else {
			return "You failed to upload " + name + " because the file was empty.";
		}
	}
	
	
}
