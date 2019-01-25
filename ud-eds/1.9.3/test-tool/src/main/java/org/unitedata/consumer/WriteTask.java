package org.unitedata.consumer;

import lombok.extern.slf4j.Slf4j;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * @author: hushi
 * @create: 2018/12/17
 */
@Slf4j
public class WriteTask extends Thread implements Runnable{

    private File outputFile;
    private String outputFilePath;
    private int linesCount;
    private static volatile boolean finished = false;

    public static boolean isFinished() {
        return finished;
    }


    public WriteTask(int linesCount, String outputFilePath) {
        super();
        this.linesCount = linesCount;
        this.outputFilePath = outputFilePath;
        this.outputFile = new File(outputFilePath);
    }

    @Override
    public void run() {
        long begin = System.currentTimeMillis();
        Path path = Paths.get(outputFile.getAbsolutePath());
        FileOutputStream outputStream;
        try {
            outputStream = new FileOutputStream(outputFile);
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }

        for (int i = 0; i < linesCount; i++) {
            try {
                String line = Main.OUTPUT_QUEUE.take();
                log.info("输出日志 : " + line);
                outputStream.write(line.getBytes());
            } catch (Exception e) {
                Thread.currentThread().interrupt();
            }
        }
        log.info("查询已结束");
        long end = System.currentTimeMillis();
        log.info("共用时" + (end - begin) + "毫秒。");
        finished = true;
    }
}
