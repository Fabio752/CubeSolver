%% testing

total_tests = 50;
passed_tests = 0;
avg_moves = 0;

for tests = 1:total_tests
    faces = init();
    [outcome, number_moves] = main(faces);
    if strcmp(outcome, 'SUCCESS')
        passed_tests = passed_tests + 1;
        avg_moves = avg_moves + number_moves;
    else
        disp(outcome)
        return;
    end    
end
avg_moves = avg_moves / passed_tests;

disp(['passed tests/total tests = ' string(passed_tests) ' / ' string(total_tests)])
disp (['average moves in passed tests = ' string(avg_moves)])