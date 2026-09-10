import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import java.io.IOException;

public class AverageStressMapper
        extends Mapper<Object, Text, Text, DoubleWritable> {

    private final Text gender = new Text();
    private final DoubleWritable stress = new DoubleWritable();

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
            gender.set(fields[2].trim());
            stress.set(Double.parseDouble(fields[9].trim()));

            context.write(gender, stress);
        } catch (NumberFormatException e) {
            // Skip malformed records
        }
    }
}