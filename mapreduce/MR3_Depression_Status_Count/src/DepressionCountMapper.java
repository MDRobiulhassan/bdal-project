import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import java.io.IOException;

public class DepressionCountMapper
        extends Mapper<Object, Text, Text, IntWritable> {

    private final Text depression = new Text();
    private static final IntWritable ONE = new IntWritable(1);

    @Override
    public void map(Object key, Text value, Context context)
            throws IOException, InterruptedException {

        String line = value.toString().trim();

        if (line.isEmpty() || line.startsWith("Student_ID")) {
            return;
        }

        String[] fields = line.split(",");

        if (fields.length < 11) {
            return;
        }

        depression.set(fields[10].trim());

        context.write(depression, ONE);
    }
}