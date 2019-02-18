package org.unitedata.consumer;

import lombok.extern.slf4j.Slf4j;
import org.unitedata.data.consumer.DataQueryProtocol;
import org.unitedata.data.consumer.domain.CreditDataProducer;

/**
 * @author: hushi
 * @create: 2018/12/17
 */
@Slf4j
public class QueryTask implements Runnable{

    private DataQueryProtocol protocol;

    private volatile boolean finished = false;

    private String contractId;
    private String transactionId = "";

    public QueryTask(DataQueryProtocol protocol, String contractId) {
        this.protocol = protocol;
        this.contractId = contractId;
    }

    @Override
    public void run() {
        while (!finished) {
            Main.In in = null;
            try {
                in = Main.INPUT_QUEUE.take();
                CreditDataProducer[] ret = (CreditDataProducer[])protocol.creditQuery(contractId, transactionId,
                        in.getMd5Code(), in.getVerifyMd5Code(), false, in.getRequestedFactor());
                log.info("剩余"+Main.INPUT_QUEUE.size()+"条记录待查询。");
                Boolean hit = false;
                for (CreditDataProducer p : ret) {
                    if (null != p.getMatchedKey())
                        hit = true;
                }
                Main.OUTPUT_QUEUE.put(new Main.Out(in, hit.toString()).toString());
                if (Main.INPUT_QUEUE.size() == 0) {
                    this.finished = true;
                    log.info("结束查询");
                }
            } catch (Exception e) {
                if (null != in) {
                    try {
                        Main.OUTPUT_QUEUE.put(new Main.Out(in, "error").toString());
                    } catch (InterruptedException e1) {
                        Thread.currentThread().interrupt();
                    }
                }
            }
        }

    }
}
