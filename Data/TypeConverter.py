# Read the text file
with open('D:/Applied Hands-on/ENGR 6412 Assignment 2/Data/Robotdata2023.txt', 'r') as file:
    lines = file.readlines()

# Create a .dat file and write the data in the required format
with open('output_file.dat', 'w') as dat_file:
    for line in lines:
        # Split the line by spaces
        values = line.split()

        # Extract the first character ('L' or 'O') and convert to 1 or 0 respectively
        first_col = '1' if values[0][0] == 'L' else '0'

        # Replace 'L' with '1' and 'O' with '0' in the rest of the values
        replaced_values = [value.replace('L', '1').replace('O', '0') for value in values[1:]]

        # Write the '1' or '0' as the first column, followed by the modified values, to the .dat file
        dat_file.write(first_col + '\t' + '\t'.join(replaced_values) + '\n')