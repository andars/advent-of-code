import java.io.*;
import java.util.*;

public class day9 {

    static Map<String, Map<String,Integer>> distances = new HashMap<String, Map<String,Integer>>();

    private static List<List<String>> solve(List<String> cities) { 
        List<List<String>> permutations = new ArrayList<List<String>>();
        if (cities.size() <= 1) {
            permutations.add(cities);
            return permutations;
        } 

        List<List<String>> downstream = solve(cities.subList(1, cities.size()));
        
        for (List<String> l : downstream) {
            for (int i = 0; i<cities.size(); i++) {
                List<String> p = new ArrayList<String>();
                p.addAll(l.subList(0,i));
                p.add(cities.get(0));
                p.addAll(l.subList(i,l.size()));
                permutations.add(p);
            } 
        }

        return permutations;

    }

    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        String line;
        while ((line = br.readLine()) != null) {
            String[] tokens = line.split(" ");
            if (!distances.containsKey(tokens[0])) {
                Map<String, Integer> nm = new HashMap<String, Integer>();
                nm.put(tokens[2], Integer.parseInt(tokens[4]));
                distances.put(tokens[0], nm); 
            } else {
                distances.get(tokens[0])
                         .put(tokens[2], Integer.parseInt(tokens[4]));
            }

            if (!distances.containsKey(tokens[2])) {
                Map<String, Integer> nm = new HashMap<String, Integer>();
                nm.put(tokens[0], Integer.parseInt(tokens[4]));
                distances.put(tokens[2], nm); 
            } else {
                distances.get(tokens[2])
                         .put(tokens[0], Integer.parseInt(tokens[4]));
            }
        }

        List<List<String>> permutations = solve(new ArrayList<String>(distances.keySet()));

        int shortest = Integer.MAX_VALUE;
        int longest = 0;
        for (List<String> p : permutations) {
            int dist = 0;
            String current = p.get(0);

            for (int i = 1; i<p.size(); i++) {
                dist += distances.get(current).get(p.get(i));
                current = p.get(i);
            } 
            if (dist < shortest) {
                shortest = dist;
            }
            if (dist > longest) {
                longest = dist;
            }
        }
        System.out.println("Shortest: " + shortest);
        System.out.println("Longest: " + longest);
    }
}
