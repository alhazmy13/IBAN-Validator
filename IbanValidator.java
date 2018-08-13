import java.util.regex.Pattern;

public class IbanValidator {
    public static boolean isValidIban(String iban) {
        if (!Pattern.compile("^[0-9A-Z]*$").matcher(iban).matches()) {
            return false;
        }
        String symbols = iban.trim();
        if (symbols.length() < 15 || symbols.length() > 34) {
            return false;
        }
        String swapped = symbols.substring(4) + symbols.substring(0, 4);
        return swapped.chars()
                .reduce(0, (int previousMod, int _char) -> {
                    int value = Integer.parseInt(Character.toString((char) _char), 36);
                    int factor = value < 10 ? 10 : 100;
                    return ((factor * previousMod + value) % 97);
                }) == 1;

    }
}
