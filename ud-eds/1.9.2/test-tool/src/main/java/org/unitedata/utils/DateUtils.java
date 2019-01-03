package org.unitedata.utils;

import java.util.Date;

/**
 * @see Date 类型处理工具
 * @author baimao
 */
public final class DateUtils {
    // .ctor
    private DateUtils(){}

    /**
     * 没毫秒的纳秒刻度数
     */
    public static final int nanoPerMilli = 1000000;
    /**
     * 每秒的毫秒刻度数
     */
    public static final int milliPerSecond = 1000;

    /**
     * 每一天的秒数
     */
    public static final int secondsPerDay = 24 * 60 * 60;

    // 纳秒计数开始纳秒时间
    private static final long startNanoTime
            = System.nanoTime();

    /**
     * 获取当前纳秒
     * @return 返回当前纳秒
     */
    public static long getNanoTime(){

        return System.nanoTime();
    }

    /**
     * 获取系统当前纳秒级时间戳
     * @return 返回系统当前纳秒级时间戳
     */
    public static long unixNano(){
        final long off = System.nanoTime() - startNanoTime;
        return (unixMill() * nanoPerMilli) + off;
    }

    /**
     * 获取指定时间的毫秒级时间戳
     * @param date 时间
     * @return 返回指定时间的毫秒级时间戳
     */
    public static long unixMill(Date date){
        return date.getTime();
    }

    /**
     * 获取指定时间的秒级时间戳
     * @param date 时间
     * @return 返回指定时间的秒级时间戳
     */
    public static long unixSec(Date date){
        return unixMill(date) / milliPerSecond;
    }

    /**
     * 获取系统当前毫秒级时间戳
     * @return 返回系统当前毫秒级时间戳
     */
    public static long unixMill(){
        return System.currentTimeMillis();
    }

    /**
     * 获取系统当前秒级时间戳
     * @return 返回系统当前秒级时间戳
     */
    public static long unixSec(){
        return unixMill() / milliPerSecond;
    }
}
