import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import java.io.IOException;

public class AverageCGPAMapper extends Mapper<Object, Text, Text, DoubleWritable> {

    private final Text department = new Text();
    private final DoubleWritable cgpa = new DoubleWritable();

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

        try {
            department.set(fields[3].trim());
            cgpa.set(Double.parseDouble(fields[4].trim()));

            context.write(department, cgpa);
        } catch (NumberFormatException e) {
            // Skip malformed records
        }
    }
}