package com.boot.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.*;

import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.multipart.MultipartFile;

import com.boot.dto.BoardAttachDTO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UploadController {
//	@Autowired
//	private CommentService service;

    @RequestMapping("/uploadAjaxAction")
    public ResponseEntity<List<BoardAttachDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
        log.info("@# uploadAjaxPost");

        List<BoardAttachDTO> list = new ArrayList<BoardAttachDTO>();
//		String uploadFolder ="C:\\Users\\user\\Desktop\\springboot\\study_springboot";
        String uploadFolder = "C:\\develop\\upload";

//		날짜별 폴더처리
        String uploadFolderPath = getFolder();
        File uploadPath = new File(uploadFolder, uploadFolderPath);
        log.info("@#uploadPath=>" + uploadPath);

        if (uploadPath.exists() == false) {
            // make yyyy/MM/dd folder
            uploadPath.mkdirs();
        }
        for (MultipartFile multipartFile : uploadFile) {
            log.info("=================================================");

            // getOriginalFilename : 업로드 되는 파일 이름
            log.info("업로드 되는 파일 이름 : " + multipartFile.getOriginalFilename());
            // getSize : 업로드 되는 파일 크기
            log.info("업로드 되는 파일 크기 : " + multipartFile.getSize());

            String uploadFileName = multipartFile.getOriginalFilename();

            UUID uuid = UUID.randomUUID();
            log.info("uuid : " + uuid);

            BoardAttachDTO boardAttachDTO = new BoardAttachDTO();
            boardAttachDTO.setFileName(uploadFileName);
            boardAttachDTO.setUuid(uuid.toString());
            boardAttachDTO.setUploadPath(uploadFolderPath);
            log.info("boardAttachDTO 01 => " + boardAttachDTO);

            uploadFileName = uuid.toString() + "_" + uploadFileName;
            log.info("@# uuid uploadFileName => " + uploadFileName);

//            saveFile : 경로하고 파일이름
            File saveFile = new File(uploadPath, uploadFileName);
            FileInputStream fis = null;

            try {
                multipartFile.transferTo(saveFile);

//                참이면 이미지 파일
                if (checkImageType(saveFile)) {
                    boardAttachDTO.setImage(true);
                    log.info("boardAttachDTO 01 => " + boardAttachDTO);

                    fis = new FileInputStream(saveFile);

//                    썸네일 파일은 s_를 앞에 추가
                    FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
//                    썸네일 파일 형식을 100/100 크기로 생성
                    Thumbnailator.createThumbnail(fis, thumbnail, 100, 100);

                    thumbnail.close();
                }
                list.add(boardAttachDTO);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (fis != null)
                        fis.close();
                } catch (Exception e2) {
                    e2.printStackTrace();
                }
            }
        } // end of for
//        return null;
//        파일 정보들을 list 객체에 담고, http 상태값을 정상으로 리턴
        return new ResponseEntity<List<BoardAttachDTO>>(list, HttpStatus.OK);
    }

    // 날짜별 폴더 생성
    private String getFolder() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = sdf.format(date);
        log.info("@# str => " + str);

        return str;
    }

    // 이미지 여부 체크
    public boolean checkImageType(File file) {
        try {
            String contentType = Files.probeContentType(file.toPath());
            log.info("@# contentType => " + contentType);

//            startWith : 파일 종류 판단
            return contentType.startsWith("image"); // 참이면 이미지 파일
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // 거짓이면 이미지파일이 아님
    }

    // 이미지 파일을 받아서 화면에 출력(byte 배열타입)
    @GetMapping("/display")
    public ResponseEntity<byte[]> getFile(String fileName) {
        log.info("@# fileName => " + fileName);

        File file = new File("C:\\develop\\upload\\" + fileName);
        log.info("@# file => " + file);

        ResponseEntity<byte[]> result = null;
        HttpHeaders headers = new HttpHeaders();

        try {
//            파일 타입을 헤더에 추가
            headers.add("Content-Type", Files.probeContentType(file.toPath()));
//            파일 정보를 byte 배열로 복사 + 헤더 정보 + http 상태 정상을 결과에 저장
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @PostMapping("/deleteFile")
    public ResponseEntity<String> deleteFile(String fileName, String type) {
        log.info("@# deleteFile fileName => " + fileName);
        File file;

        try {
//            URLDecoder.decode : 서버에 올라간 파일을 삭제하기 위해서 디코딩
            file = new File("C:\\develop\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
            log.info("@# file => " + file);
            file.delete();

//            이미지 파일이면 썸네일도 삭제
            if (type.equals("image")) {
//                getAbsolutePath : 절대경로(full path)
                String largeFileName = file.getAbsolutePath().replace("s_", "");
                log.info("@# largeFileName => " + largeFileName);
                file.delete();
            }
        } catch (Exception e) {
            e.printStackTrace();

//            에외 오류 발생시 not found처리
            return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
        }

//        deleted : success의 result로 전송
        return new ResponseEntity<String>("deleted", HttpStatus.OK);
    }
}
